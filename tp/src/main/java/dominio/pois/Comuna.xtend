package dominio.pois

import org.uqbar.geodds.Polygon
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validable
import dependencias.Validator
import org.uqbar.commons.utils.Observable
import com.fasterxml.jackson.annotation.JsonIgnore

@Accessors
@Observable
class Comuna implements Validator {
	@Validable
	String nombre
	@Validable
	@JsonIgnore
	Polygon poligono
	
	new(String nombre, Polygon poligono){
		this.nombre = nombre
		this.poligono = poligono
	}
	
	/*def String listaDeTags(){
		var String lista
		lista=nombre
	}*/
	
	
	
}