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
import java.util.List
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
	Busqueda buscador
	DemoraBusqueda observerDemoraAbasto
	DemoraBusqueda observerDemoraFlorida
	DemoraBusqueda observerDemoraColon

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

	List<Accion> accionesAbasto
	List<Accion> accionesFlorida
	List<Accion> accionesColon

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

		observerAlmacenamientoAbasto = new AlmacenamientoDeBusqueda()
		observerAlmacenamientoFlorida = new AlmacenamientoDeBusqueda()
		observerAlmacenamientoColon = new AlmacenamientoDeBusqueda()

		observerDemoraAbasto = new DemoraBusqueda(admin, 2)
		observerDemoraFlorida = new DemoraBusqueda(admin, 2)
		observerDemoraColon = new DemoraBusqueda(admin, 2)

		observerDemoraAbasto.mailSender = mockedMailSender
		observerDemoraFlorida.mailSender = mockedMailSender
		observerDemoraColon.mailSender = mockedMailSender

		observerBusqPorFechaAbasto = new BusquedasPorFecha(observerAlmacenamientoAbasto)
		observerBusqPorFechaFlorida = new BusquedasPorFecha(observerAlmacenamientoFlorida)
		observerBusqPorFechaColon = new BusquedasPorFecha(observerAlmacenamientoColon)

		observerResParcColon = new ResultadosParciales(observerAlmacenamientoColon)
		observerResParcAbasto = new ResultadosParciales(observerAlmacenamientoAbasto)
		observerResParcFlorida = new ResultadosParciales(observerAlmacenamientoFlorida)

		observerResTotFlorida = new ResultadosTotales(observerAlmacenamientoFlorida)
		observerResTotAbasto = new ResultadosTotales(observerAlmacenamientoAbasto)
		observerResTotColon = new ResultadosTotales(observerAlmacenamientoColon)

		accionesAbasto = new ArrayList<Accion>
		accionesAbasto.addAll(
			#[observerAlmacenamientoAbasto, observerDemoraAbasto, observerBusqPorFechaAbasto, observerResParcAbasto,
				observerResTotAbasto])
		accionesFlorida = new ArrayList<Accion>
		accionesFlorida.addAll(
			#[observerAlmacenamientoFlorida, observerDemoraFlorida, observerBusqPorFechaFlorida, observerResParcFlorida,
				observerResTotFlorida])
		accionesColon = new ArrayList<Accion>
		accionesColon.addAll(
			#[observerAlmacenamientoColon, observerDemoraColon, observerBusqPorFechaColon, observerResParcColon,
				observerResTotColon])

		terminalAbasto = new Consulta("Abasto", buscador, new ArrayList<Accion>(accionesAbasto))
		terminalFlorida = new Consulta("Florida", buscador, new ArrayList<Accion>(accionesFlorida))
		terminalTeatroColon = new Consulta("Teatro Colon", buscador, new ArrayList<Accion>(accionesColon))
		admin = new Administrador(buscador)
		buscador.busquedaObservers.addAll(accionesAbasto)
		buscador.busquedaObservers.addAll(accionesFlorida)
		buscador.busquedaObservers.addAll(accionesColon)

		observerAlmacenamientoAbasto.dueño = terminalAbasto
		observerAlmacenamientoFlorida.dueño = terminalFlorida
		observerAlmacenamientoColon.dueño = terminalTeatroColon

		observerDemoraAbasto.dueño = terminalAbasto
		observerDemoraFlorida.dueño = terminalFlorida
		observerDemoraColon.dueño = terminalFlorida

		observerBusqPorFechaAbasto.dueño=terminalAbasto
		observerBusqPorFechaFlorida.dueño=terminalFlorida
		observerBusqPorFechaColon.dueño=terminalTeatroColon

		observerResParcAbasto.dueño=terminalAbasto
		observerResParcFlorida.dueño=terminalFlorida
		observerResParcColon.dueño=terminalTeatroColon

		observerResTotAbasto.dueño=terminalAbasto
		observerResTotFlorida.dueño=terminalFlorida
		observerResTotColon.dueño=terminalTeatroColon

	}

	@Test
	def void testAgregarObservadores() {
		Assert.assertTrue(buscador.busquedaObservers.size == 15)
	}

	@Test
	def void testEliminarObservadores() {
		buscador.eliminarObservador(observerDemoraAbasto)
		Assert.assertTrue(buscador.busquedaObservers.size == 14)
		Assert.assertFalse(buscador.busquedaObservers.exists[unObservador|unObservador == observerDemoraAbasto])
	}

	@Test
	def void testMandarMailAlAdministrador() {
		reset(mockedMailSender)
		observerDemoraAbasto.tiempoDeEspera = -1
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
	def void tesReporteBusquedasPorFecha() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 5, 17))
		Assert.assertEquals(2, cantidad)
	}

	@Test(expected=NoValidoException)
	def testDeshabilitarReporteBusquedasPorFecha() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("libreria")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 5, 17))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.deshabilitarAccion(observerBusqPorFechaAbasto)
		var cant = observerBusqPorFechaAbasto.busquedasPorFecha(new LocalDate(16, 05, 17))

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
	def testDesactivarAlmacenamiento() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 17))
		Assert.assertEquals(1, cantidad)
		terminalAbasto.deshabilitarAccion(observerAlmacenamientoAbasto)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 17))
		Assert.assertEquals(1, cantidad)

	}

	@Test
	def testActivarAlmacenamiento() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		var cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 17))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.deshabilitarAccion(observerAlmacenamientoAbasto)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 17))
		Assert.assertEquals(2, cantidad)
		terminalAbasto.habilitarAccion(observerAlmacenamientoAbasto)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamientoAbasto.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 17))
		Assert.assertEquals(3, cantidad)

	}
}
