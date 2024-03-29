package test

import dominio.pois.PuntoDeInteres
import fixtures.FixtureBancoJson
import interfazAServiciosExternos.AdapterJson
import java.util.List

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import stubs.StubServicioExternoBanco

public class TestAdapterJson {

	String json1
	String json3
	
	
	@Before
	def void setUp() {
		var StubServicioExternoBanco stubBanco = new StubServicioExternoBanco
		var FixtureBancoJson fixtureBanco = new FixtureBancoJson
		stubBanco.agregarBancoJson(fixtureBanco.obtenerBancoJson1)
		json1 = stubBanco.buscar("Banco")
		stubBanco.agregarBancoJson(fixtureBanco.obtenerBancoJson2)
		stubBanco.agregarBancoJson(fixtureBanco.obtenerBancoJson3)
		json3 = stubBanco.buscar("Banco")
	}

	@Test
	def void debeTransformarJsonASucursalBanco() {
		var AdapterJson adapterJson = new AdapterJson
		var List<PuntoDeInteres> listaDeBancos = adapterJson.transformarDeJSONaClaseBanco(json1)
		Assert.assertEquals(1, listaDeBancos.size)
		var List<PuntoDeInteres> listaDeBancos2 = adapterJson.transformarDeJSONaClaseBanco(json3)
		Assert.assertEquals(3, listaDeBancos2.size)
		
	}

}
