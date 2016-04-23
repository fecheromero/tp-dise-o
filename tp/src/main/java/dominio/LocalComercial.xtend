package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

@Accessors
public abstract class LocalComercial extends PuntoDeInteres {

	var String rubro

	override String listaDeTags() {
		super.listaDeTags().concat(" ".concat(rubro))
	}

	override estaDisponible(DateTime unMomento, String nombreDeServicio) {
		return this.horario.esHabilElMomento(unMomento)
	}
}
