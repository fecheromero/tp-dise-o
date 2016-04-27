package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.NoValidoException

@Accessors
public abstract class LocalComercial extends PuntoDeInteres {

	var String rubro

	override String listaDeTags() {
		super.listaDeTags().concat(" ".concat(rubro))
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