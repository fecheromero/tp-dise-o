package test

import dominio.Busqueda
import org.junit.Before
import dominio.Repositorio
import fixtures.LibreriaFixture
import fixtures.ParadaColectivoFixture
import stubs.StubServicioExternoCGP
import fixtures.CentroDTOFixture
import interfazAServiciosExternos.AdapterCGP
import interfazAServiciosExternos.AdapterJson
import stubs.StubServicioExternoBanco
import fixtures.FixtureBancoJson
import org.junit.Test
import org.junit.Assert
import dominio.locales.LocalComercial
import dominio.pois.ParadaDeColectivo
import decorator.Terminal
import org.uqbar.geodds.Point

class TestBusqueda {
	Busqueda busqueda
	Repositorio repo
	StubServicioExternoCGP stubServExtCGP
	StubServicioExternoBanco stubServExtBanco
	AdapterCGP adapterCGP
	AdapterJson adapterJson
	LocalComercial libreria
	ParadaDeColectivo _114
	Terminal terminal
	@Before
	def void SetUp(){
		repo=Repositorio.getInstance
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
		terminal=new Terminal("ejecutador",new Point(1,2),busqueda)
		}
		@Test
		def void buscarUnObjetoDelRepoLocal(){
			busqueda.buscar("libreria",terminal)
			Assert.assertSame(terminal.rdo.head.nombre, "libreria don Pepito")
		}
		@Test
		def void buscarUnObjetoDeLaInterfazDeCGPs(){
						busqueda.buscar("Rivadavia 4577",terminal)
			
			Assert.assertEquals(terminal.rdo.head.direccion.callePrincipal,"Rivadavia 4577")
		}
		@Test
		def void buscarUnObjetoDeLaInterfazDeBancos(){
						busqueda.buscar("Banco de la plaza",terminal)
			
			Assert.assertEquals(terminal.rdo.head.nombre,"Banco de la Plaza Avellaneda")
		}
	}