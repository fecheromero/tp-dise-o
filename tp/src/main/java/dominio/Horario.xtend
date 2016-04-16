package dominio

import org.joda.time.DateTime

import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class Horario {
	HashSet<Integer> diasHabilesPoi
	HashSet<Turno> turnosDisponibles

	new(HashSet<Integer> _diashabiles, HashSet<Turno> _turnos) {
		this.diasHabilesPoi = _diashabiles
		this.turnosDisponibles = _turnos
	}

	def boolean esHabilElMomento(DateTime unMomento) {
		return this.estaEnDiaHabil(unMomento) && this.estaDentroDeUnTurno(unMomento)
	}

	def estaDentroDeUnTurno(DateTime unMomento) {
		return this.turnosDisponibles.exists[unTurno|unTurno.horaDentroDelTurno(horaDelMomento(unMomento))]
	}

	def horaDelMomento(DateTime unMomento) {
		return unMomento.toLocalTime()
	}

	def estaEnDiaHabil(DateTime unMomento) {
		return this.diasHabilesPoi.contains(unMomento.getDayOfWeek())
	}

}
