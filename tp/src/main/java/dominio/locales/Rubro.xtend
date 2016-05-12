package dominio.locales

import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validator
import dependencias.Validable

@Accessors
class Rubro implements Validator {
	@Validable
	String nombre
	var double DISTANCIA_MAXIMA 
	
	new(String _nombre,Double _distanciamaxima){
		this.nombre=_nombre
		DISTANCIA_MAXIMA = _distanciamaxima
		
		
		
	}
	
	
	
}

