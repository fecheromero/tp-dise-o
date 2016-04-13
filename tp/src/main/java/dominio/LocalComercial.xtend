package dominio

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public abstract class LocalComercial extends PuntoDeInteres {

	
		var String rubro
		override String listaDeTags(){
			super.listaDeTags().concat(" ".concat(rubro))
		}
	override boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	}

}
