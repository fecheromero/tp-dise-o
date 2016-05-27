package stubs

import com.google.gson.Gson
import interfazAServiciosExternos.InterfazBanco
import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class StubServicioExternoBanco implements InterfazBanco  {
	HashSet<StubBancoJSON> bancosExternos = new HashSet<StubBancoJSON>
	
	override String buscar(String palabraClave) {
		var Gson gson = new Gson()
		return gson.toJson(bancosExternos)
	}
	
	 def void agregarBancoJson(StubBancoJSON bancoJson){
		bancosExternos.add(bancoJson)
	}
	

}
	