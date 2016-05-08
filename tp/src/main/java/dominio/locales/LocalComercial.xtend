package dominio.locales

import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.NoValidoException
import dominio.tiempo.Horario 
import dominio.pois.PuntoDeInteres
import dominio.pois.Direccion

@Accessors
public class LocalComercial extends PuntoDeInteres {

	Rubro rubro

	override String listaDeTags() {
		super.listaDeTags().concat(" ".concat(rubro.nombre))
	}
	
	new(String _nombre, Horario _horario, Direccion _direccion, Rubro _rubro){
		this.nombre = _nombre
		this.horario= _horario
		this.direccion=_direccion
		rubro=_rubro 
		
	}
	
	override validate() {

		if (PuntoDeInteres.declaredFields.filter[field|field.name!="servicios"].exists [ field |
			field.accessible = true
			field.get(this) == null

		])	throw new NoValidoException("El Poi no es valido")
		else {
			this.direccion.validate()
		}
	
}
}