package test

import dominio.Busqueda
import decorator.Terminal
import decorator.Acciones
import decorator.Registros
import org.junit.Before
import dominio.Repositorio
import fixtures.ParadaColectivoFixture
import fixtures.LibreriaFixture
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import stubs.StubServicioExternoCGP
import interfazAServiciosExternos.AdapterCGP
import fixtures.CentroDTOFixture
import stubs.StubServicioExternoBanco
import fixtures.FixtureBancoJson
import interfazAServiciosExternos.AdapterJson
import decorator.Administrador
import org.mockito.ArgumentMatcher
import org.mockito.invocation.InvocationOnMock
import org.mockito.stubbing.Answer

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import org.junit.Test
import decorator.ControlarTardanza
import decorator.RegistroDeBusqueda
import decorator.RegistrarBusqueda
import org.junit.Assert
import java.text.SimpleDateFormat
import java.util.Date
import excepciones.SendAdminException

class TestDecorator {
	Busqueda busqueda
	Terminal terminal1
	Acciones acciones
	Registros registros
	Repositorio repo
	LocalComercial libreria
	ParadaDeColectivo _114
	StubServicioExternoCGP stubServExtCGP
	AdapterCGP adapterCGP
	StubServicioExternoBanco stubServExtBanco
	AdapterJson adapterJson
	Administrador administrador
	Terminal terminal2
	@Before
	def void setUp(){
			repo=Repositorio.instance
		libreria=new LibreriaFixture().obtenerLibreria
		repo.create(libreria)
		_114=new ParadaColectivoFixture().obtenerParadaColectivo
		repo.create(_114)
		stubServExtCGP=new StubServicioExternoCGP
		stubServExtCGP.agregarCentroDTO(new CentroDTOFixture().centro1)
		stubServExtCGP.agregarCentroDTO(new CentroDTOFixture().centro2)
		adapterCGP=new AdapterCGP()
		adapterCGP.origen = stubServExtCGP
		stubServExtBanco=new StubServicioExternoBanco
		stubServExtBanco.agregarBancoJson(new FixtureBancoJson().obtenerBancoJson1)
		stubServExtBanco.agregarBancoJson(new FixtureBancoJson().obtenerBancoJson2)
		adapterJson=new AdapterJson
		adapterJson.origen = stubServExtBanco
		busqueda=new Busqueda()
		busqueda.agregarOrigen(repo)
		busqueda.agregarOrigen(adapterCGP)
		busqueda.agregarOrigen(adapterJson)
		terminal1=new Terminal("terminal1",busqueda)
		terminal2=new Terminal("terminal2",busqueda)
		acciones=Acciones.getInstance
		acciones.reset
		acciones.agregar("Controlar tardanza", new ControlarTardanza(2,administrador))
		acciones.agregar("Registrar busqueda", new RegistrarBusqueda())
		registros=Registros.getInstance
		registros.reset
		administrador=new Administrador()
		terminal1.habilitarAccion("Registrar busqueda")
		terminal1.habilitarAccion("Controlar tardanza")
		terminal2.habilitarAccion("Registrar busqueda")
		terminal2.habilitarAccion("Controlar tardanza")
															
			
		}
		
		@Test
		def void TestGuardadoDeAcciones(){
			
			Assert.assertEquals(acciones.acciones.size,2)
		}
		@Test
		def void TestPedidoDeAcciones(){
			Assert.assertTrue(acciones.accion("Registrar busqueda").class==RegistrarBusqueda)
		}
		@Test
		def void TestDecorado(){
			
			Assert.assertTrue(terminal1.buscador.class==ControlarTardanza)
		}
		@Test
		def void TestBusquedaCompleta(){
			
			Assert.assertEquals(terminal1.buscar("libreria").head.nombre,"libreria don Pepito")
			}
		@Test
		def void TestSeRegistra(){
				terminal1.buscar("libreria")
				
				Assert.assertEquals(registros.registros.size,1)
				
			Assert.assertEquals(registros.registros.head.fecha,new SimpleDateFormat("dd/MM/yyyy").format(new Date())
)
			Assert.assertEquals(registros.registros.head.fraseBuscada,"libreria")
		}
		@Test
		def void TestNoSeRegistra(){
			terminal1.deshabilitarAccion("Registrar busqueda")
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,0)
		}
		@Test
		def void TestSeEnviaMail(){
			registros.reset()
			var ControlarTardanza controlarTardanza2=new ControlarTardanza (0,administrador)
			var int cantSends
			var ControlarTardanza mockedControlarTardanza=spy(controlarTardanza2)
			doThrow(new SendAdminException).when(mockedControlarTardanza).sendMail(administrador)
			acciones.agregar("Controlar tardanza2",mockedControlarTardanza)
			terminal1.deshabilitarAccion("Controlar tardanza")
			terminal1.habilitarAccion("Controlar tardanza2")
			try{terminal1.buscar("libreria")
			} catch(SendAdminException e){cantSends+=1}
			Assert.assertEquals(cantSends,1)
		}
		@Test
		def void TestNoSeEnviaMail(){
			registros.reset()
			var ControlarTardanza controlarTardanza2=new ControlarTardanza (0,administrador)
			var int cantSends
			var ControlarTardanza mockedControlarTardanza=spy(controlarTardanza2)
			doThrow(new SendAdminException).when(mockedControlarTardanza).sendMail(administrador)
			acciones.agregar("Controlar tardanza2",mockedControlarTardanza)
			terminal1.deshabilitarAccion("Controlar tardanza")
			try{terminal1.buscar("libreria")
			} catch(SendAdminException e){cantSends+=1}
			Assert.assertEquals(cantSends,0)
		}
		@Test
		def void TestHabilitarYDeshabilitarRegistro(){
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,1)
			terminal1.deshabilitarAccion("Registrar busqueda")
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,1)
			terminal1.habilitarAccion("Registrar busqueda")
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,2)
			
		}
		@Test
		def void TestPruebaDeInformePorFecha(){
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.informeCantDeBusquedasXFecha.get(new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			),1)
						terminal1.buscar("pepito")
			Assert.assertEquals(registros.informeCantDeBusquedasXFecha.get(new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			),2)}
		@Test
		def void TestPruebaDeInformePorTerminal(){
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("terminal1"),10)
			terminal1.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("terminal1"),20)
			terminal2.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("terminal2"),10)
		}
		@Test
		def void TestParcialesPorTerminal(){
			terminal1.buscar("libreria")
			terminal2.buscar("libreria")
			terminal1.buscar("libreria")
			Assert.assertArrayEquals(registros.parcialesPorTerminal(terminal1).toArray,#[10,10])
			Assert.assertArrayEquals(registros.parcialesPorTerminal(terminal2).toArray,#[10])
		}
		}
		
