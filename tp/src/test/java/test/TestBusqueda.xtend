package test

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
import dominio.Busqueda
import dominio.PerfilesDeUsuario.Consulta

class TestBusqueda {
	Busqueda busqueda
	Repositorio repo
	StubServicioExternoCGP stubServExtCGP
	StubServicioExternoBanco stubServExtBanco
	AdapterCGP adapterCGP
	AdapterJson adapterJson
	LocalComercial libreria
	ParadaDeColectivo _114
	Consulta terminalAbasto
	
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
		}
		@Test
		def void buscarUnObjetoDelRepoLocal(){
			Assert.assertSame(busqueda.buscar("libreria" , terminalAbasto).head.nombre, "libreria don Pepito")
		}
		@Test
		def void buscarUnObjetoDeLaInterfazDeCGPs(){
			Assert.assertEquals(busqueda.buscar("Rivadavia 4577",terminalAbasto).head.direccion.callePrincipal,"Rivadavia 4577")
		}
		@Test
		def void buscarUnObjetoDeLaInterfazDeBancos(){
			Assert.assertEquals(busqueda.buscar("Banco de la plaza",terminalAbasto).head.nombre,"Banco de la Plaza Avellaneda")
}
	}