package test

import dominio.Busqueda
import decorator.BusquedaExecuter
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
import decorator.InformePorFecha
import java.util.HashMap
import decorator.InformeTotalUsuario
import java.util.ArrayList
import excepciones.NoValidoException
import decorator.InformePorTerminal

class TestDecorator {
	Busqueda busqueda
	BusquedaExecuter exec1
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
	BusquedaExecuter exec2
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
		exec1=new BusquedaExecuter("exec1",busqueda)
		exec2=new BusquedaExecuter("exec2",busqueda)
		acciones=Acciones.getInstance
		acciones.reset
		acciones.agregar("Controlar tardanza", new ControlarTardanza(2,administrador))
		acciones.agregar("Registrar busqueda", new RegistrarBusqueda())
		registros=Registros.getInstance
		registros.reset
		administrador=new Administrador()
		exec1.habilitarAccion("Registrar busqueda")
		exec1.habilitarAccion("Controlar tardanza")
		exec2.habilitarAccion("Registrar busqueda")
		exec2.habilitarAccion("Controlar tardanza")
															
			
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
			
			Assert.assertTrue(exec1.buscador.class==ControlarTardanza)
		}
		@Test
		def void TestBusquedaCompleta(){
			
			Assert.assertEquals(exec1.buscar("libreria").head.nombre,"libreria don Pepito")
			}
		@Test
		def void TestSeRegistra(){
				exec1.buscar("libreria")
				
				Assert.assertEquals(registros.registros.size,1)
				
			Assert.assertEquals(registros.registros.head.fecha,new SimpleDateFormat("dd/MM/yyyy").format(new Date())
)
			Assert.assertEquals(registros.registros.head.fraseBuscada,"libreria")
		}
		@Test
		def void TestNoSeRegistra(){
			exec1.deshabilitarAccion("Registrar busqueda")
			exec1.buscar("libreria")
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
			exec1.deshabilitarAccion("Controlar tardanza")
			exec1.habilitarAccion("Controlar tardanza2")
			try{exec1.buscar("libreria")
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
			exec1.deshabilitarAccion("Controlar tardanza")
			try{exec1.buscar("libreria")
			} catch(SendAdminException e){cantSends+=1}
			Assert.assertEquals(cantSends,0)
		}
		@Test
		def void TestHabilitarYDeshabilitarRegistro(){
			exec1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,1)
			exec1.deshabilitarAccion("Registrar busqueda")
			exec1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,1)
			exec1.habilitarAccion("Registrar busqueda")
			exec1.buscar("libreria")
			Assert.assertEquals(registros.registros.size,2)
			
		}
		@Test
		def void TestPruebaDeInformePorFecha(){
			exec1.buscar("libreria")
			Assert.assertEquals(registros.informeCantDeBusquedasXFecha.get(new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			),1)
						exec1.buscar("pepito")
			Assert.assertEquals(registros.informeCantDeBusquedasXFecha.get(new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			),2)}
		@Test
		def void TestPruebaDeInformePorexec(){
			exec1.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("exec1"),10)
			exec1.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("exec1"),20)
			exec2.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("exec2"),10)
		}
		@Test
		def void TestParcialesPorexec(){
			exec1.buscar("libreria")
			exec2.buscar("libreria")
			exec1.buscar("libreria")
			Assert.assertArrayEquals(registros.parcialesPorTerminal(exec1).toArray,#[10,10])
			Assert.assertArrayEquals(registros.parcialesPorTerminal(exec2).toArray,#[10])
		}
		@Test
		def void Testexec1MuestrInformes(){
			exec1.buscar("libreria")
			Assert.assertEquals((exec1.pedirInforme(InformePorFecha.instance) as HashMap<String,Integer>).get((new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			)),1)		
			Assert.assertEquals((exec1.pedirInforme(InformeTotalUsuario.instance )as HashMap<String,Integer>).get("exec1"),10)
			Assert.assertArrayEquals((exec1.pedirInforme(InformePorTerminal.instance) as ArrayList<Integer>).toArray,#[10])
			
		}
		@Test(expected=NoValidoException)
		def void TestQuitarInforme(){
			exec1.buscar("libreria")
			exec1.quitarInforme(InformePorFecha.instance)
			exec1.pedirInforme(InformePorFecha.instance)
			Assert.assertEquals(exec1.informadores.size,2)
		}
		@Test
		def void TestAgregarInforme(){
			exec1.quitarInforme(InformePorFecha.instance)
			exec1.agregarInforme(InformePorFecha.instance)
			exec1.pedirInforme(InformePorFecha.instance)
			
		}
		}
		
		
