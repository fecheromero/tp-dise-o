package test

import com.google.gson.Gson
import dominio.pois.SucursalBanco
import interfazAServiciosExternos.AdapterJson
import java.util.ArrayList
import org.junit.Assert
import org.junit.Before
import org.junit.Test

public class TestAdapterJson {
	StubBancoJSON bancoExt1
	StubBancoJSON bancoExt2
	StubBancoJSON bancoExt3
	ArrayList<String> serviciosExt
	ArrayList<String> serviciosExt2
	String json1
	String json2
	ArrayList<StubBancoJSON> bancosExternos
	AdapterJson stubAdapterJson
		
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
		bancoExt1 = new StubBancoJSON("Banco de la Plaza", 35.9338322, 72.348353, "Avellaneda", "Javier Loeschbor",
			serviciosExt)
		bancoExt2 = new StubBancoJSON("Banco Santander", 56.9338322, 42.348353, "Quilmes", "Adrian Fanego",
			serviciosExt2)
		bancoExt3 = new StubBancoJSON("Banco Santander", 13.5555555, 54.765432, "CABA", "Lucas Soriano", serviciosExt)
		bancosExternos = new ArrayList<StubBancoJSON>
		bancosExternos.add(bancoExt1)
		bancosExternos.add(bancoExt2)
		bancosExternos.add(bancoExt3)
		var bancosExternos1 = new ArrayList<StubBancoJSON>
		bancosExternos1.add(bancoExt2)
		var Gson gson = new Gson()
		json1 = gson.toJson(bancosExternos)
		json2 = gson.toJson(bancosExternos1)
		
	}

	@Test
	def void debeTransformarJsonASucursalBanco() {
		stubAdapterJson =  new AdapterJson(json1)
		var ArrayList<SucursalBanco> listaDeBancos = stubAdapterJson.transformarDeJSONaClaseBanco()
		Assert.assertEquals(3, listaDeBancos.size)
		stubAdapterJson.listaDeBancosEnJson = json2
		var ArrayList<SucursalBanco> listaDeBancos2 = stubAdapterJson.transformarDeJSONaClaseBanco()
		Assert.assertEquals(1, listaDeBancos2.size)
		
		System::out.println(listaDeBancos2.get(0).nombre)
////		
//		//var HashSet<SucursalBanco> sucursales = Sets.newHashSet(bancosExternos.map[unBancoExterno|pasarDeBancoJsonASucBanco(unBancoExterno)])
////		
//		var listaServicios = unaSucursalExt.servicios.map[unServicio|Transformer.servicioJSONAServicio(unServicio)]
////		var ArrayList<String> servisExt  =unaSucursalExt.servicios
////		var String unServExt = servisExt.get(0)
////		
//		
//		var servicios = new HashSet<Servicio>(listaServicios)
//		var Servicio servi = servicios.get(0)
////		var Horario hor = Transformer.horarioBancario()
//		//var Servicio servicio = new Servicio(unServExt,hor )
////		var SucursalBanco sucu = new SucursalBanco(servicios, transformador.direccionDeBanco(unaSucursalExt),
////			unaSucursalExt.banco + "" + unaSucursalExt.sucursal)
////		var String nombre = new String(gson.fromJson(json,))
//		// 
	}

}
