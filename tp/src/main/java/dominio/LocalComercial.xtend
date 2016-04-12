package dominio

import org.joda.time.DateTime

public abstract class LocalComercial extends PuntoDeInteres {

	override boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	}

}
