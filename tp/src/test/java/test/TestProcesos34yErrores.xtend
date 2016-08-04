package test

import dominio.Repositorio
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import stubs.StubServicioExternoCGP
import interfazAServiciosExternos.AdapterCGP
import stubs.StubServicioExternoBanco
import interfazAServiciosExternos.AdapterJson
import dominio.PerfilesDeUsuario.Consulta
import dominio.PerfilesDeUsuario.Administrador
import dominio.Busqueda
import observer.DemoraBusqueda
import observer.AlmacenamientoDeBusqueda
import observer.MailSender
import observer.BusquedasPorFecha
import observer.ResultadosParciales
import observer.ResultadosTotales
import org.junit.Before
import fixtures.LibreriaFixture
import fixtures.ParadaColectivoFixture
import fixtures.CentroDTOFixture
import fixtures.FixtureBancoJson
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import org.junit.Test
import procesos.AgregarAccionesUsuarios
import org.junit.Assert
import procesos.EnviarMail
import procesos.RepositorioProcesos
import procesos.ProcesosMultiples
import java.util.ArrayList
import observer.Accion
import java.util.List

class TestProcesos34yErrores {
	Repositorio repo
	LocalComercial libreria
	ParadaDeColectivo _114
	StubServicioExternoCGP stubServExtCGP
	AdapterCGP adapterCGP
	StubServicioExternoBanco stubServExtBanco
	AdapterJson adapterJson
	Consulta terminalAbasto
	Consulta terminalFlorida
	Consulta terminalTeatroColon
	Administrador admin
	Busqueda buscador

	DemoraBusqueda observerDemora
	DemoraBusqueda observerDemora2

	AlmacenamientoDeBusqueda observerAlmacenamiento

	MailSender mockedMailSender

	BusquedasPorFecha observerBusqPorFecha

	ResultadosParciales observerResParc

	ResultadosTotales observerResTot

	AgregarAccionesUsuarios agregarAcciones
	AgregarAccionesUsuarios agregarAcciones2
	ProcesosMultiples procesoMultiple
	EnviarMail enviarMail

	RepositorioProcesos repoProcesos

	@Before
	def void setUp() {

		repo = Repositorio.instance
		libreria = new LibreriaFixture().obtenerLibreria
		repo.create(libreria)
		_114 = new ParadaColectivoFixture().obtenerParadaColectivo
		repo.create(_114)
		stubServExtCGP = new StubServicioExternoCGP
		stubServExtCGP.agregarCentroDTO(new CentroDTOFixture().centro1)
		stubServExtCGP.agregarCentroDTO(new CentroDTOFixture().centro2)
		adapterCGP = new AdapterCGP()
		adapterCGP.origen = stubServExtCGP
		stubServExtBanco = new StubServicioExternoBanco
		stubServExtBanco.agregarBancoJson(new FixtureBancoJson().obtenerBancoJson1)
		stubServExtBanco.agregarBancoJson(new FixtureBancoJson().obtenerBancoJson2)
		adapterJson = new AdapterJson
		adapterJson.origen = stubServExtBanco
		buscador = new Busqueda()
		buscador.agregarOrigen(repo)
		buscador.agregarOrigen(adapterCGP)
		buscador.agregarOrigen(adapterJson)

		mockedMailSender = mock(typeof(MailSender))

		observerAlmacenamiento = new AlmacenamientoDeBusqueda()

		observerDemora = new DemoraBusqueda(admin, 2)
		observerDemora2 = new DemoraBusqueda(admin, 3)
		observerDemora.mailSender = mockedMailSender
		observerDemora2.mailSender = mockedMailSender
		observerBusqPorFecha = new BusquedasPorFecha()

		observerResParc = new ResultadosParciales()

		observerResTot = new ResultadosTotales()

		var lista = new ArrayList<Accion>(
			#[observerAlmacenamiento, observerDemora, observerBusqPorFecha, observerResParc, observerResTot])

		terminalAbasto = new Consulta("Abasto", buscador, lista)
		terminalFlorida = new Consulta("Florida", buscador, lista)
		terminalTeatroColon = new Consulta("Teatro Colon", buscador, lista)

		buscador.busquedaObservers.addAll(lista)
		/*		observerBusqPorFechaAbasto.buscador = buscadorAbasto
		 * 		observerBusqPorFechaFlorida.buscador = buscadorFlorida
		 * 		observerBusqPorFechaColon.buscador = buscadorColon

		 * 		observerResParcColon.buscador = buscadorColon
		 * 		observerResParcAbasto.buscador = buscadorAbasto
		 * 		observerResParcFlorida.buscador = buscadorFlorida

		 * 		observerResTotFlorida.buscador = buscadorFlorida
		 * 		observerResTotAbasto.buscador = buscadorAbasto
		 * 		observerResTotColon.buscador = buscadorColon
		 */
		agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto], #[observerDemora2])
		agregarAcciones2 = new AgregarAccionesUsuarios(#[terminalTeatroColon, terminalFlorida], #[observerDemora2])
		procesoMultiple = new ProcesosMultiples(#[agregarAcciones, agregarAcciones2])
		admin = new Administrador(buscador)

		enviarMail = new EnviarMail(admin)
		enviarMail.mailSender = mockedMailSender
		admin.accionDeError = enviarMail
		repoProcesos = RepositorioProcesos.getInstance
		repoProcesos.reset
	}

	@Test
	def void testAgregarAccionesAUsuarios() {
		try {
			reset(mockedMailSender)
			Assert.assertTrue(buscador.busquedaObservers.size == 5)
			agregarAcciones.exec(admin)
		} catch (Exception e) {
			verify(mockedMailSender, times(0)).send(any(typeof(Administrador)))
		}
		Assert.assertTrue(buscador.busquedaObservers.size == 6)

	}

	@Test
	def void testProcesoMultiple() {
		try {
			reset(mockedMailSender)
			Assert.assertTrue(buscador.busquedaObservers.size == 5)
			admin.exec(procesoMultiple)
		} catch (Exception e) {
			verify(mockedMailSender, times(0)).send(any(typeof(Administrador)))
		}
		Assert.assertTrue(buscador.busquedaObservers.size == 6)

	}

	@Test(expected=Exception)
	def void testProcesoConError() {
		Assert.assertTrue(buscador.busquedaObservers.size == 5)
		agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora])
		agregarAcciones.exec(admin)
		Assert.assertTrue(buscador.busquedaObservers.size == 6)
	}

	@Test
	def void testMandarMailAlAdministrador() {
		try {
			reset(mockedMailSender)
			agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora])
			agregarAcciones.exec(admin)
		} catch (Exception e) {
			verify(mockedMailSender, times(0)).send(any(typeof(Administrador)))
		}
	}

	@Test
	def void testAlmacenamientoDeProcesoOK() {
		
		admin.exec(agregarAcciones)
		Assert.assertTrue(repoProcesos.listaDeResultados.size == 1)
//		Assert.assertTrue(terminalAbasto.listaDeAcciones.contains(observerDemora2))
		Assert.assertTrue(repoProcesos.listaDeResultados.get(0).resultado=="ok")
		Assert.assertTrue(repoProcesos.listaDeResultados.size == 1)
	}

	@Test
	def void testAlmacenamientoDeProcesoConError() {
		
			reset(mockedMailSender)
			agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora])
			admin.exec(agregarAcciones)
			Assert.assertTrue(repoProcesos.listaDeResultados.size == 1)
			verify(mockedMailSender, times(1)).send(any(typeof(Administrador)))
			Assert.assertTrue(repoProcesos.listaDeResultados.get(0).resultado == "error")
		
	}

}
