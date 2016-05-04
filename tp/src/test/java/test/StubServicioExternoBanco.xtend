package test

import dominio.ServicioExternoBancos
import java.util.ArrayList
import dominio.BancoJSON
import com.google.gson.Gson

class StubServicioExternoBanco implements ServicioExternoBancos{
	ArrayList<BancoJSON> BancosJson
	
	new(ArrayList<BancoJSON> _BancosJson){
		this.BancosJson =_BancosJson
	}	
	
		
		override String buscar(String nombre){
			var Gson gson = new Gson();
			var String representacionJSON = new String (gson.toJson(BancosJson.filter[unBanco|unBanco.banco==nombre]))
			return representacionJSON
		}
}