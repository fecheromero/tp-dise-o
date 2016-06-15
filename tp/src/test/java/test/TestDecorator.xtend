package test

import static org.mockito.Mockito.*
import decorator.Terminal
import dominio.Busqueda
import decorator.ControlarTardanza
import decorator.MailSender
import decorator.RegistrarBusqueda
import decorator.RegistroDeBusqueda
import org.uqbar.geodds.Point
import decorator.Administrador
import decorator.Registros
import dominio.Repositorio
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import stubs.StubServicioExternoCGP
import interfazAServiciosExternos.AdapterCGP
import stubs.StubServicioExternoBanco
import interfazAServiciosExternos.AdapterJson
import fixtures.CentroDTOFixture
import fixtures.FixtureBancoJson
import fixtures.LibreriaFixture
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import java.text.SimpleDateFormat
import java.util.Date
import excepciones.SendAdminException

class TestDecorator {
	Terminal term1
	Busqueda busqueda
	ControlarTardanza controlador
	MailSender mailSender
	RegistrarBusqueda registrador
	Registros registros
	Administrador admin
		Repositorio repo
	LocalComercial libreria
	ParadaDeColectivo _114
	StubServicioExternoCGP stubServExtCGP
	AdapterCGP adapterCGP
	StubServicioExternoBanco stubServExtBanco
	AdapterJson adapterJson
	@Before
	def void setUp(){
		registros=Registros.instance
		admin=new Administrador()
		mailSender=new MailSender()
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
	controlador=new ControlarTardanza(busqueda,mailSender,2,admin)
		registrador=new RegistrarBusqueda(controlador)
		term1=new Terminal("terminal1", new Point(1,2),registrador)			
	}
	
			@Test
		def void TestSeRegistra(){
				term1.buscar("libreria")
				
				Assert.assertEquals(registros.registros.size,1)
				
			Assert.assertEquals(registros.registros.head.fecha,new SimpleDateFormat("dd/MM/yyyy").format(new Date())
)
			Assert.assertEquals(registros.registros.head.fraseBuscada,"libreria")
		}
			@Test
		def void TestSeEnviaMail(){
			registros.reset()
			var int cantSends
			var MailSender mockedMailSender=spy(mailSender)
			var controlador2=new ControlarTardanza(busqueda,mockedMailSender,2,admin)
			registrador=new RegistrarBusqueda(controlador2)
		term1=new Terminal("terminal1", new Point(1,2),registrador)			
			doThrow(new SendAdminException).when(mockedMailSender).sendMail(admin)
			try{term1.buscar("libreria")
			} catch(SendAdminException e){cantSends+=1}
			Assert.assertEquals(cantSends,1)
		}
	@Test
		def void TestPruebaDeInformePorFecha(){
			registros.reset()
			term1.buscar("libreria")
			Assert.assertEquals(registros.informeCantDeBusquedasXFecha.get(new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			),1)
		term1.buscar("pepito")
			Assert.assertEquals(registros.informeCantDeBusquedasXFecha.get(new SimpleDateFormat("dd/MM/yyyy").format(new Date())
			),2)}
		@Test
		def void TestPruebaDeInformePorTerminal(){
			registros.reset()
			term1.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("terminal1"),10)
			term1.buscar("libreria")
			Assert.assertEquals(registros.informeTotalesPorTerminal.get("terminal1"),20)
		}
		@Test
		def void TestParcialesPorexec(){
			term1.buscar("libreria")
			term1.buscar("libreria")
			Assert.assertArrayEquals(registros.parcialesPorTerminal(term1).toArray,#[10,10])
			}
	}