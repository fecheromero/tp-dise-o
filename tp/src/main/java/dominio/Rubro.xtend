package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Rubro extends LocalComercial {
	String nombre
	var double DISTANCIA_MAXIMA 
	
	new(String _nombre,Double _distanciamaxima){
		this.nombre=_nombre
		DISTANCIA_MAXIMA = _distanciamaxima
		
		
		
	}
	
	
	
}

