package dominio.pois

import org.uqbar.geodds.Polygon
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.ValidableObject
import dependencias.Validable

@Accessors

class Comuna extends ValidableObject {
	@Validable
	String nombre
	@Validable
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