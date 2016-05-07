/*package test

import dominio.Transformer
import dominio.SucursalBanco
import java.util.HashSet
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import dominio.BancoJSON
import java.util.ArrayList
import com.google.gson.Gson
import java.lang.reflect.Type
import com.google.gson.reflect.TypeToken
import com.google.common.collect.Sets
import dominio.Servicio
import dominio.Horario
import dominio.Horario.Dia

import dominio.Turno
import org.joda.time.LocalTime

public class TestBancoEnServicioExterno {
BancoJSON bancoExt1
BancoJSON bancoExt2
BancoJSON bancoExt3
ArrayList<String> serviciosExt
ArrayList<String> serviciosExt2
HashSet<BancoJSON> bancosExt
String json
//HashSet<SucursalBanco> sucursales
//SucursalBanco unaSucursal

@Before
def void setUp() {
		serviciosExt = new ArrayList<String>
		serviciosExt.add("cobro cheques")
		serviciosExt.add("depósitos")
		serviciosExt.add("extracciones")
		serviciosExt.add("transferencias")
		serviciosExt.add("créditos")
		serviciosExt2 = new ArrayList<String>
		serviciosExt2.add("atención al cliente")
		serviciosExt2.add("depósitos")
		serviciosExt2.add("extracciones")
		serviciosExt2.add("transferencias")
		serviciosExt2.add("créditos")
		serviciosExt2.add("plazos fijo")
		bancoExt1 = new BancoJSON("Banco de la Plaza", 35.9338322, 72.348353, "Avellaneda", "Javier Loeschbor",
			serviciosExt)
		bancoExt2 = new BancoJSON("Banco Santander", 56.9338322, 42.348353, "Quilmes", "Adrian Fanego", serviciosExt2)
		bancoExt3 = new BancoJSON("Banco Santander", 13.5555555, 54.765432, "CABA", "Lucas Soriano",
			serviciosExt)
		bancosExt = new HashSet<BancoJSON>
		bancosExt.add(bancoExt1)
		bancosExt.add(bancoExt2)
		bancosExt.add(bancoExt3)
		var Gson gson = new Gson()
		json = gson.toJson(bancosExt)
	//	 sucursales = transformador.transformarDeJSONaClaseBanco(json)
			//unaSucursal = sucursales.get(0)  
	}

	@Test
	def void debeDevolverJSONEnUnObjeto() {
			var Gson gson = new Gson()
		var Type tipoListaDeBancosJson = new TypeToken<ArrayList<BancoJSON>>() {
		}.getType()
		var HashSet<BancoJSON> bancosExternos = new HashSet<BancoJSON>(gson.fromJson(json, tipoListaDeBancosJson))
		var BancoJSON unaSucursalExt = bancosExternos.get(0)
//		
		//var HashSet<SucursalBanco> sucursales = Sets.newHashSet(bancosExternos.map[unBancoExterno|pasarDeBancoJsonASucBanco(unBancoExterno)])
//		
		var listaServicios = unaSucursalExt.servicios.map[unServicio|Transformer.servicioJSONAServicio(unServicio)]
//		var ArrayList<String> servisExt  =unaSucursalExt.servicios
//		var String unServExt = servisExt.get(0)
//		
		
		var servicios = new HashSet<Servicio>(listaServicios)
		var Servicio servi = servicios.get(0)
//		var Horario hor = Transformer.horarioBancario()
		//var Servicio servicio = new Servicio(unServExt,hor )
//		var SucursalBanco sucu = new SucursalBanco(servicios, transformador.direccionDeBanco(unaSucursalExt),
//			unaSucursalExt.banco + "" + unaSucursalExt.sucursal)
//		var String nombre = new String(gson.fromJson(json,))
		// Assert.assertEquals( "Banco de la Plaza",unaSucursal.nombre)
		System::out.println(servi.nombre)
	}

}
*/