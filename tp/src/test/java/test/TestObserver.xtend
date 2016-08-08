package test

import dominio.Busqueda
import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.Consulta
import dominio.Repositorio
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import fixtures.CentroDTOFixture
import fixtures.FixtureBancoJson
import fixtures.LibreriaFixture
import fixtures.ParadaColectivoFixture
import interfazAServiciosExternos.AdapterCGP
import interfazAServiciosExternos.AdapterJson
import java.util.ArrayList
import observer.Accion
import observer.AlmacenamientoDeBusqueda
import observer.BusquedasPorFecha
import observer.DemoraBusqueda
import observer.MailSender
import observer.RepositorioDeConsultas
import observer.ResultadosParciales
import observer.ResultadosTotales
import org.joda.time.LocalDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import stubs.StubServicioExternoBanco
import stubs.StubServicioExternoCGP

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

import excepciones.NoValidoException

class TestObserver {
	Repositorio repo
	RepositorioDeConsultas baseConsultas
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

	AlmacenamientoDeBusqueda observerAlmacenamiento

	MailSender mockedMailSender
	BusquedasPorFecha observerBusqPorFecha

	ResultadosParciales observerResParc

	ResultadosTotales observerResTot

	@Before
	def void setUp() {


		repo = Repositorio.getInstance
		baseConsultas = RepositorioDeConsultas.getInstance
		baseConsultas.reset
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
		observerDemora.mailSender = mockedMailSender

		observerBusqPorFecha = new BusquedasPorFecha

		observerResParc = new ResultadosParciales

		observerResTot = new ResultadosTotales

		var accionesAbasto = new ArrayList<Accion>
		accionesAbasto.addAll(
			#[observerAlmacenamiento, observerDemora, observerBusqPorFecha, observerResParc, observerResTot])
		var accionesFlorida = new ArrayList<Accion>
		accionesFlorida.addAll(
			#[observerAlmacenamiento, observerDemora, observerBusqPorFecha, observerResParc, observerResTot])
		var accionesColon = new ArrayList<Accion>
		accionesColon.addAll(
			#[observerAlmacenamiento, observerDemora, observerBusqPorFecha, observerResParc, observerResTot])

		buscador.busquedaObservers.addAll(accionesAbasto)

		terminalAbasto = new Consulta("Abasto", buscador, accionesAbasto)
		terminalFlorida = new Consulta("Florida", buscador, accionesFlorida)
		terminalTeatroColon = new Consulta("Teatro Colon", buscador, accionesColon)

	}

	@Test
	def void testAgregarObservadores() {

		buscador.eliminarObservador(observerDemora)
		Assert.assertTrue(buscador.busquedaObservers.size == 4)
		buscador.agregarObservador(observerDemora)
		Assert.assertTrue(buscador.busquedaObservers.size == 5)
	}

	@Test
	def void testEliminarObservadores() {

		buscador.eliminarObservador(observerDemora)
		Assert.assertTrue(buscador.busquedaObservers.size == 4)
		Assert.assertFalse(buscador.busquedaObservers.exists[unObservador|unObservador == observerDemora])
	}

	@Test
	def void testMandarMailAlAdministrador() {
		reset(mockedMailSender)
		observerDemora.tiempoDeEspera = -1
		terminalAbasto.buscar("libreria")
		verify(mockedMailSender, times(1)).send(any(typeof(Administrador)))
	}

	@Test
	def void testNoMandarMailAlAdministrador() {
		reset(mockedMailSender)
		terminalAbasto.buscar("_114")
		verify(mockedMailSender, times(0)).send(any(typeof(Administrador)))
	}

	@Test
	def void testReporteBusquedasPorFecha() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(3, cantidad)

		terminalTeatroColon.buscar("pepito")
		var cantidad2 = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalFlorida)
		Assert.assertEquals(4, cantidad2)

	}

	@Test(expected=NoValidoException)
	def void testDeshabilitarReporteBusquedasPorFecha() {

		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(3, cantidad)
		terminalAbasto.deshabilitarAccion(observerBusqPorFecha)
		observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)

	}

	@Test(expected=NoValidoException)
	def void testDeshabilitarAccionYaDeshabilitada() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(3, cantidad)
		terminalAbasto.deshabilitarAccion(observerBusqPorFecha)
		terminalAbasto.deshabilitarAccion(observerBusqPorFecha)
	}

	@Test(expected=NoValidoException)
	def void testErrorParaHabilitarAccionYaHabilitada() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")

		var cantidad = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(3, cantidad)
		terminalAbasto.habilitarAccion(observerBusqPorFecha)

	}

	@Test
	def void testVerificarQueSeDeshabilito() {
		terminalFlorida.deshabilitarAccion(observerDemora)
		Assert.assertFalse(terminalFlorida.estaHabilitadaLaAccion(observerDemora))
		terminalTeatroColon.deshabilitarAccion(observerResParc)
		Assert.assertFalse(terminalTeatroColon.estaHabilitadaLaAccion(observerResParc))
	}

	@Test
	def void testVerificarQueSeHabilito() {
		terminalFlorida.deshabilitarAccion(observerDemora)
		Assert.assertFalse(terminalFlorida.estaHabilitadaLaAccion(observerDemora))
		terminalFlorida.habilitarAccion(observerDemora)
		Assert.assertTrue(terminalFlorida.estaHabilitadaLaAccion(observerDemora))
	}

	@Test

	def void testCantidadDeResultadosParcialesPorTerminal() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		terminalTeatroColon.buscar("pepito")
		var cantidadDeAbasto = observerResParc.resultadosParciales(terminalAbasto)
		Assert.assertEquals(#[10, 10, 10], cantidadDeAbasto)

		var cantidadDeFlorida = observerResParc.resultadosParciales(terminalFlorida)
		Assert.assertEquals(#[10, 10], cantidadDeFlorida)

		var cantidadDeColon = observerResParc.resultadosParciales(terminalTeatroColon)
		Assert.assertEquals(#[10], cantidadDeColon)
	}

	@Test
	def void testCantidadDeResultadosTotalesPorTerminal() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalTeatroColon.buscar("pepito")

		var cantidadTotalDeAbasto = observerResTot.resultadosTotales(terminalAbasto)
		Assert.assertEquals(30, cantidadTotalDeAbasto)

		var cantidadDeFlorida = observerResTot.resultadosTotales(terminalFlorida)
		Assert.assertEquals(20, cantidadDeFlorida)

		var cantidadDeColon = observerResTot.resultadosTotales(terminalTeatroColon)
		Assert.assertEquals(10, cantidadDeColon)
	}

	@Test
	def void testDesactivaryReactivarAlmacenamiento() {
		terminalAbasto.buscar("_114")
		terminalAbasto.buscar("libreria")

		var cantidad = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(2, cantidad)

		terminalAbasto.deshabilitarAccion(observerAlmacenamiento)
		Assert.assertFalse(terminalAbasto.estaHabilitadaLaAccion(observerAlmacenamiento))
		
		terminalAbasto.buscar("pepe")
		var cantidad2 = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(2, cantidad2)

		terminalAbasto.habilitarAccion(observerAlmacenamiento)
		terminalFlorida.buscar("pepe")
		var cantidad3 = observerBusqPorFecha.buscarPorFecha(new LocalDate(), terminalAbasto)
		Assert.assertEquals(3, cantidad3)
	}

	@Test(expected=NoValidoException)
	def void testErrorCantidadDeResultadosTotalesPorTerminalDeshabilitado() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalAbasto.buscar("_114")

		var cantidadTotalDeAbasto = observerResTot.resultadosTotales(terminalAbasto)
		Assert.assertEquals(30, cantidadTotalDeAbasto)
		
		terminalAbasto.deshabilitarAccion(observerResTot)
		
		observerResTot.resultadosTotales(terminalAbasto)		

	}
	
	@Test(expected=NoValidoException)
	def void testErrorCantidadDeResultadosParcialesPorTerminalDeshabilitado() {
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		
		var cantidadDeFlorida = observerResParc.resultadosParciales(terminalFlorida)
		Assert.assertEquals(#[10, 10], cantidadDeFlorida)
				
		terminalFlorida.deshabilitarAccion(observerResParc)
		
		observerResParc.resultadosParciales(terminalFlorida)		

	}
}