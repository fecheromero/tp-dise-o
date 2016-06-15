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
import java.util.ArrayList
import observer.Accion
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import org.junit.Test
import procesos.AgregarAccionesUsuarios
import org.junit.Assert
import procesos.EnviarMail
import procesos.RepositorioProcesos
import procesos.ProcesosMultiples

class TestProcesos34yErrores{
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
	Busqueda buscadorAbasto
	Busqueda buscadorFlorida
	Busqueda buscadorColon

	DemoraBusqueda observerDemora
	DemoraBusqueda observerDemora2
	DemoraBusqueda observerDemora3

	AlmacenamientoDeBusqueda observerAlmacenamientoAbasto
	AlmacenamientoDeBusqueda observerAlmacenamientoFlorida
	AlmacenamientoDeBusqueda observerAlmacenamientoColon

	MailSender mockedMailSender
	BusquedasPorFecha observerBusqPorFechaAbasto
	BusquedasPorFecha observerBusqPorFechaFlorida
	BusquedasPorFecha observerBusqPorFechaColon

	ResultadosParciales observerResParcAbasto
	ResultadosParciales observerResParcFlorida
	ResultadosParciales observerResParcColon

	ResultadosTotales observerResTotAbasto
	ResultadosTotales observerResTotFlorida
	ResultadosTotales observerResTotColon

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
		buscadorAbasto = new Busqueda()
		buscadorAbasto.agregarOrigen(repo)
		buscadorAbasto.agregarOrigen(adapterCGP)
		buscadorAbasto.agregarOrigen(adapterJson)

		buscadorFlorida = new Busqueda()
		buscadorFlorida.agregarOrigen(repo)
		buscadorFlorida.agregarOrigen(adapterCGP)
		buscadorFlorida.agregarOrigen(adapterJson)

		buscadorColon = new Busqueda()
		buscadorColon.agregarOrigen(repo)
		buscadorColon.agregarOrigen(adapterCGP)
		buscadorColon.agregarOrigen(adapterJson)

		mockedMailSender = mock(typeof(MailSender))

		observerAlmacenamientoAbasto = new AlmacenamientoDeBusqueda()
		observerAlmacenamientoFlorida = new AlmacenamientoDeBusqueda()
		observerAlmacenamientoColon = new AlmacenamientoDeBusqueda()

		observerDemora = new DemoraBusqueda(admin, 2)
		observerDemora2 = new DemoraBusqueda(admin, 3)
		observerDemora3 = new DemoraBusqueda(admin, 3)
		observerDemora.mailSender = mockedMailSender
		observerDemora2.mailSender = mockedMailSender
		observerDemora3.mailSender = mockedMailSender

		observerBusqPorFechaAbasto = new BusquedasPorFecha(observerAlmacenamientoAbasto)
		observerBusqPorFechaFlorida = new BusquedasPorFecha(observerAlmacenamientoFlorida)
		observerBusqPorFechaColon = new BusquedasPorFecha(observerAlmacenamientoColon)

		observerResParcColon = new ResultadosParciales(observerAlmacenamientoColon)
		observerResParcAbasto = new ResultadosParciales(observerAlmacenamientoAbasto)
		observerResParcFlorida = new ResultadosParciales(observerAlmacenamientoFlorida)

		observerResTotFlorida = new ResultadosTotales(observerAlmacenamientoFlorida)
		observerResTotAbasto = new ResultadosTotales(observerAlmacenamientoAbasto)
		observerResTotColon = new ResultadosTotales(observerAlmacenamientoColon)

		var accionesAbasto = new ArrayList<Accion>
		accionesAbasto.addAll(
			#[observerAlmacenamientoAbasto, observerDemora, observerBusqPorFechaAbasto, observerResParcAbasto,
				observerResTotAbasto])
		var accionesFlorida = new ArrayList<Accion>
		accionesFlorida.addAll(
			#[observerAlmacenamientoFlorida, observerDemora, observerBusqPorFechaFlorida, observerResParcFlorida,
				observerResTotFlorida])
		var accionesColon = new ArrayList<Accion>
		accionesColon.addAll(
			#[observerAlmacenamientoColon, observerDemora, observerBusqPorFechaColon, observerResParcColon,
				observerResTotColon])

		buscadorAbasto.busquedaObservers.addAll(accionesAbasto)
		buscadorFlorida.busquedaObservers.addAll(accionesFlorida)
		buscadorColon.busquedaObservers.addAll(accionesColon)

		terminalAbasto = new Consulta("Abasto", buscadorAbasto)
		terminalFlorida = new Consulta("Florida", buscadorFlorida)
		terminalTeatroColon = new Consulta("Teatro Colon", buscadorColon)

		observerBusqPorFechaAbasto.buscador = buscadorAbasto
		observerBusqPorFechaFlorida.buscador = buscadorFlorida
		observerBusqPorFechaColon.buscador = buscadorColon

		observerResParcColon.buscador = buscadorColon
		observerResParcAbasto.buscador = buscadorAbasto
		observerResParcFlorida.buscador = buscadorFlorida

		observerResTotFlorida.buscador = buscadorFlorida
		observerResTotAbasto.buscador = buscadorAbasto
		observerResTotColon.buscador = buscadorColon

		agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora2])
		agregarAcciones2 = new AgregarAccionesUsuarios(#[terminalTeatroColon, terminalFlorida], #[observerDemora3])
		procesoMultiple=new ProcesosMultiples(#[agregarAcciones,agregarAcciones2])
		admin = new Administrador(buscadorFlorida)

		enviarMail = new EnviarMail(admin)

		admin.accionDeError = enviarMail
		repoProcesos = new RepositorioProcesos
		admin.repositorio = repoProcesos
	}

	@Test
	def void testAgregarAccionesAUsuarios() {
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 5)
		agregarAcciones.exec(admin)
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 6)

	}
	@Test
	def void testProcesoMultiple(){
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 5)
		admin.exec(procesoMultiple)
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 7)

	}

	@Test(expected=Exception)
	def void testProcesoConError() {
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 5)
		agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora])
		agregarAcciones.exec(admin)
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 6)
	}

	@Test
	def void testMandarMailAlAdministrador() {
		try {reset(mockedMailSender)
		agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora])
		agregarAcciones.exec(admin)
		}catch(Exception e){
		verify(mockedMailSender, times(0)).send(any(typeof(Administrador)))
		}
	}

	@Test
	def void testAlmacenamientoDeProcesoOK() {
		admin.exec(agregarAcciones)
		Assert.assertTrue(repoProcesos.listaDeResultados.get(0).resultado == "ok")
		Assert.assertTrue(repoProcesos.listaDeResultados.size == 1)
	}
	@Test
	def void testAlmacenamientoDeProcesoConError(){
		try {reset(mockedMailSender)
		agregarAcciones = new AgregarAccionesUsuarios(#[terminalAbasto, terminalFlorida], #[observerDemora2])
		agregarAcciones.exec(admin)
		}catch(Exception e){
		verify(mockedMailSender, times(0)).send(any(typeof(Administrador)))
		Assert.assertTrue(repoProcesos.listaDeResultados.get(0).resultado == "error")
		Assert.assertTrue(repoProcesos.listaDeResultados.size == 1)		
		}
	}

}

