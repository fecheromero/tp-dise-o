package procesos

import java.util.ArrayList
import dominio.Repositorio
import dominio.locales.LocalComercial
import excepciones.ProcesingException
import java.util.HashSet
import dominio.PerfilesDeUsuario.Administrador

class ActualizarLocalesComerciales extends Proceso {
	
	String text
	
	 new(String _text){
		text=_text
	}
	
	override def void exec (Administrador adm){
		
		val String[] separado=text.split(";")
		val LocalComercial local=Repositorio.instance.puntos.filter[poi|poi.class==LocalComercial].
		findFirst[local|local.nombre==separado.get(0)] as LocalComercial
		if(local==null){}
		else{
		var HashSet<String> tags=new HashSet<String>
		tags.addAll(separado.get(1).split(" "))
		
			tags.addAll(local.otrosTags.split(" "))
			
			local.otrosTags = tags.fold("",[palabra1, palabra2| palabra1.concat(" ").concat(palabra2)])
			}
			
	}
	
}