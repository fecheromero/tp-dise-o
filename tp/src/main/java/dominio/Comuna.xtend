package dominio

import org.uqbar.geodds.Polygon
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors

class Comuna {
	String nombre
	Polygon poligono
	
	new(String nombre, Polygon poligono){
		this.nombre = nombre
		this.poligono = poligono
	}
	
	def String listaDeTags(){
		var String lista
		lista=nombre
	}
	
	
	
}