package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import excepciones.NoValidoException
import dominio.pois.PuntoDeInteres
import dominio.pois.Direccion
@Accessors
public class ParadaDeColectivo extends PuntoDeInteres {
	
	new(Direccion _direccion, String _nombre) {
		this.direccion = _direccion
		this.nombre = _nombre
		 DISTANCIA_MAXIMA=0.1
	}

	override estaDisponible(DateTime unMomento,String nombreDeServicio){
		return true
	}
	override validate() {

		if (PuntoDeInteres.declaredFields.filter[field|field.name!="servicios" && field.name!="horario"].exists [ field |
			field.accessible = true
			field.get(this) == null

		])	throw new NoValidoException("El Poi no es valido")
		else {
			this.direccion.validate()
		}


}
}
