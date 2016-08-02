package test

import dominio.Busqueda
import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.Consulta
import dominio.Repositorio
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import excepciones.NoValidoException
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

class TestObserver {
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
		observerDemora.mailSender = mockedMailSender

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
		
		observerBusqPorFechaAbasto.buscador=buscadorAbasto
		observerBusqPorFechaFlorida.buscador=buscadorFlorida
		observerBusqPorFechaColon.buscador=buscadorColon
		
		observerResParcColon.buscador=buscadorColon
		observerResParcAbasto.buscador=buscadorAbasto
		observerResParcFlorida.buscador=buscadorFlorida
		
		observerResTotFlorida.buscador=buscadorFlorida
		observerResTotAbasto.buscador=buscadorAbasto
		observerResTotColon.buscador=buscadorColon
	
	
	}

	@Test
	def void testAgregarObservadores() {
		buscadorFlorida.eliminarObservador(observerDemora)
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 4)
		buscadorFlorida.agregarObservador(observerDemora)
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 5)
	}

	@Test
	def void testEliminarObservadores() {
		buscadorFlorida.eliminarObservador(observerDemora)
		Assert.assertTrue(buscadorFlorida.busquedaObservers.size == 4)
		Assert.assertFalse(buscadorFlorida.busquedaObservers.exists[unObservador|unObservador == observerDemora])
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
		var cantidad =observerBusqPorFechaAbasto.busquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(2, cantidad)
	}
	@Test
	def void testDeshabilitarReporteBusquedasPorFecha() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerBusqPorFechaAbasto.busquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.deshabilitarAccion(observerBusqPorFechaAbasto)
		observerBusqPorFechaAbasto.busquedasPorFecha(new LocalDate(2016, 05, 18))
		
	}
	@Test
	def void testDeshabilitarAccionYaDeshabilitada() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.deshabilitarAccion(observerBusqPorFechaAbasto)
		terminalAbasto.deshabilitarAccion(observerBusqPorFechaAbasto)

	}

	@Test
	def void testErrorParaHabilitarAccionYaHabilitada() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.habilitarAccion(observerBusqPorFechaAbasto)

	}

	@Test
	def void testCantidadDeResultadosParcialesPorTerminal() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		var cantidadDeAbasto = observerAlmacenamientoAbasto.resultadosParcialesPorTerminal()
		Assert.assertEquals(#[10, 10, 10], cantidadDeAbasto)
	}

	@Test
	def void testVerificarQueSeDeshabilito() {
		terminalFlorida.deshabilitarAccion(observerDemora)
		Assert.assertFalse(terminalFlorida.estaHabilitadaLaAccion(observerDemora))
	}

	@Test
	def void testVerificarQueSeHabilito() {
		terminalFlorida.deshabilitarAccion(observerDemora)
		Assert.assertFalse(terminalFlorida.estaHabilitadaLaAccion(observerDemora))
		terminalFlorida.habilitarAccion(observerDemora)
		Assert.assertTrue(terminalFlorida.estaHabilitadaLaAccion(observerDemora))
	}

	@Test
	def void testCantidadDeResultadosTotalesPorTerminal() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		var cantidadTotalDeAbasto = observerAlmacenamientoAbasto.resultadosTotalesPorTerminal()
		Assert.assertEquals(30, cantidadTotalDeAbasto)
	}

	@Test
	def void testDesactivarAlmacenamiento() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(1, cantidad)
		terminalAbasto.deshabilitarAccion(observerAlmacenamientoAbasto)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(1, cantidad)

	}

	@Test
	def void testActivarAlmacenamiento() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.deshabilitarAccion(observerAlmacenamientoAbasto)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.habilitarAccion(observerAlmacenamientoAbasto)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 18))
		Assert.assertEquals(3, cantidad)

	}
}