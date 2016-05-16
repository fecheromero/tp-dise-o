package test

import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.Consulta
import dominio.Busqueda
import observer.DemoraBusqueda
import org.junit.Before
import observer.AlmacenamientoDeBusqueda
import org.junit.Test
import observer.MailSender
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import dominio.Repositorio
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import stubs.StubServicioExternoCGP
import interfazAServiciosExternos.AdapterCGP
import stubs.StubServicioExternoBanco
import interfazAServiciosExternos.AdapterJson
import fixtures.LibreriaFixture
import fixtures.ParadaColectivoFixture
import fixtures.CentroDTOFixture
import fixtures.FixtureBancoJson
import org.junit.Assert
import org.joda.time.LocalDate

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
	DemoraBusqueda observerDemora
	AlmacenamientoDeBusqueda observerAlmacenamiento
	MailSender mockedMailSender

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
		observerDemora = new DemoraBusqueda(admin, 2)
		observerDemora.mailSender = mockedMailSender
		terminalAbasto = new Consulta("Abasto", buscador)
		terminalFlorida = new Consulta("Florida", buscador)
		terminalTeatroColon = new Consulta("Teatro Colon", buscador)
		admin = new Administrador(buscador)
		observerAlmacenamiento = new AlmacenamientoDeBusqueda()
		buscador.agregarObservador(observerAlmacenamiento)
		buscador.agregarObservador(observerDemora)

	}

	@Test
	def void testAgregarObservadores() {
		Assert.assertTrue(buscador.busquedaObservers.size == 2)
	}

	@Test
	def void testEliminarObservadores() {
		buscador.eliminarObservador(observerDemora)
		Assert.assertTrue(buscador.busquedaObservers.size == 1)
		Assert.assertTrue(buscador.busquedaObservers.exists[unObservador|unObservador == observerAlmacenamiento])
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
	def void tesReporteBusquedasPorFecha() {
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		var cantidad = observerAlmacenamiento.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 16))
		Assert.assertEquals(2, cantidad)
	}

	@Test
	def void testCantidadDeResultadosParcialesPorTerminal() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		var cantidadDeAbasto = observerAlmacenamiento.resultadosParcialesPorTerminal(terminalAbasto)
		Assert.assertEquals(#[10,10,10],cantidadDeAbasto)
	}
	@Test
	def void testCantidadDeResultadosTotalesPorTerminal() {
		terminalAbasto.buscar("libreria")
		terminalAbasto.buscar("banco")
		terminalFlorida.buscar("_114")
		terminalFlorida.buscar("libreria")
		terminalAbasto.buscar("_114")
		var cantidadTotalDeAbasto = observerAlmacenamiento.resultadosTotalesPorTerminal(terminalAbasto)
		Assert.assertEquals(30,cantidadTotalDeAbasto)
	}
	@Test
	def testDesactivarAlmacenamiento(){
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		var cantidad = observerAlmacenamiento.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 16))
		Assert.assertEquals(2, cantidad)
		buscador.eliminarObservador(observerAlmacenamiento)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamiento.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 16))
		Assert.assertEquals(2, cantidad)
				
	}
	@Test
	def testActivarAlmacenamiento(){
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		var cantidad = observerAlmacenamiento.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 16))
		Assert.assertEquals(2, cantidad)
		buscador.eliminarObservador(observerAlmacenamiento)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamiento.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 16))
		Assert.assertEquals(2, cantidad)
		buscador.agregarObservador(observerAlmacenamiento)
		terminalAbasto.buscar("_114")
		terminalFlorida.buscar("libreria")
		cantidad = observerAlmacenamiento.cantidadDeBusquedasPorFecha(new LocalDate(2016, 05, 16))
		Assert.assertEquals(4, cantidad)
				
	}
}
