package test

import dominio.Transformer
import dominio.SucursalBanco
import java.util.HashSet
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestBancoEnServicioExterno {
	
 String json 
 Transformer transformador
HashSet<SucursalBanco> sucursales
SucursalBanco unaSucursal
String nombreSuc
@Before
	def void setUp() {
		json = new String( '[{ "banco": "Banco de la Plaza”,"x": 35.9338322,"y": 72.348353,"sucursal": "Avellaneda","gerente": "Javier Loeschbor","servicios": [ "cobro cheques", "depósitos", "extracciones","transferencias", "créditos"]}]')
		sucursales = transformador.transformarDeJSONaClaseBanco(json)
		unaSucursal = sucursales.get(1)
		nombreSuc = unaSucursal.getNombre()
		}
	}
	
	
@Test
def void debeDevolverJSONEnUnObjeto() {
		Assert.assertTrue( (unasucursal.nombre).equals("Banco de la Plaza”))


}
}
