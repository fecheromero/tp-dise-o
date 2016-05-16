package test

import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.Consulta
import observer.BusquedaObserver
import dominio.Busqueda
import observer.ResultadosPorBusqueda
import observer.DemoraBusqueda
import org.junit.Before
import observer.AlmacenamientoDeBusqueda

class TestObserver {
	Consulta terminalAbasto
	Consulta terminalFlorida
	Consulta terminalTeatroColon
	Administrador admin
	Busqueda buscador
	ResultadosPorBusqueda registro
	DemoraBusqueda observerDemora
	AlmacenamientoDeBusqueda observerAlmacenamiento
	
	@Before
	def void setUp(){
			
			
			observerDemora=new DemoraBusqueda(admin,2)				
			buscador=new Busqueda()
			terminalAbasto=new Consulta(buscador)
			terminalFlorida=new Consulta(buscador)
			terminalTeatroColon=new Consulta(buscador)
			admin=new Administrador(buscador)
			
			
	}
/* 	@Test
 +		def void TestGuardadoDeAcciones(){
 +			
 +			Assert.assertEquals(acciones.acciones.size,2)
 +		}
 +		@Test
 +		def void TestPedidoDeAcciones(){
 +			Assert.assertTrue(acciones.accion("Registrar busqueda").class==RegistrarBusqueda)
 +		}
 +		@Test
 +		def void TestDecorado(){
 +			
 +			Assert.assertTrue(terminal1.buscador.class==ControlarTardanza)
 +		}
 +		@Test
 +		def void TestBusquedaCompleta(){
 +			
 +			Assert.assertEquals(terminal1.buscar("libreria").head.nombre,"libreria don Pepito")
 +			}
 +		@Test
 +		def void TestSeRegistra(){
 +				terminal1.buscar("libreria")
 +				
 +				Assert.assertEquals(registros.registros.size,1)
 +				
 +			Assert.assertEquals(registros.registros.head.fecha,"15/05/2016")
 +			Assert.assertEquals(registros.registros.head.fraseBuscada,"libreria")
 +		}
 +		@Test
 +		def void TestNoSeRegistra(){
 +			terminal1.deshabilitarAccion("Registrar busqueda")
 +			terminal1.buscar("libreria")
 +			Assert.assertEquals(registros.registros.size,0)
 +		}
 +		@Test
 +		def void TestSeEnviaMail(){
 +			registros.reset()
 +			var ControlarTardanza controlarTardanza2=new ControlarTardanza (0,administrador)
 +			var int cantSends
 +			var ControlarTardanza mockedControlarTardanza=spy(controlarTardanza2)
 +			doThrow(new SendAdminException).when(mockedControlarTardanza).sendMail(administrador)
 +			acciones.agregar("Controlar tardanza2",mockedControlarTardanza)
 +			terminal1.deshabilitarAccion("Controlar tardanza")
 +			terminal1.habilitarAccion("Controlar tardanza2")
 +			try{terminal1.buscar("libreria")
 +			} catch(SendAdminException e){cantSends+=1}
 +			Assert.assertEquals(cantSends,1)
 +		}
 +		@Test
 +		def void TestNoSeEnviaMail(){
 +			registros.reset()
 +			var ControlarTardanza controlarTardanza2=new ControlarTardanza (0,administrador)
 +			var int cantSends
 +			var ControlarTardanza mockedControlarTardanza=spy(controlarTardanza2)
 +			doThrow(new SendAdminException).when(mockedControlarTardanza).sendMail(administrador)
 +			acciones.agregar("Controlar tardanza2",mockedControlarTardanza)
 +			terminal1.deshabilitarAccion("Controlar tardanza")
 +			try{terminal1.buscar("libreria")
 +			} catch(SendAdminException e){cantSends+=1}
 +			Assert.assertEquals(cantSends,0)
 +		}
 +		@Test
 +		def void TestHabilitarYDeshabilitarRegistro(){
 +			terminal1.buscar("libreria")
 +			Assert.assertEquals(registros.registros.size,1)
 +			terminal1.deshabilitarAccion("Registrar busqueda")
 +			terminal1.buscar("libreria")
 +			Assert.assertEquals(registros.registros.size,1)
 +			terminal1.habilitarAccion("Registrar busqueda")
 +			terminal1.buscar("libreria")
 +			Assert.assertEquals(registros.registros.size,2)
 +			
 +		}*/
 }