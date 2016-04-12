package dominio

import org.joda.time.DateTime
import java.util.Set

public class Horario {
	Set<Integer> diasHabilesPoi
	Set<Turno> turnosDisponibles

	def void setearDiasHabiles(Set<Integer> diasHabiles) {
		this.diasHabilesPoi = diasHabiles
	}

	def void setearTurnosDisponibles(Set<Turno> turnos) {
		this.turnosDisponibles = turnos
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
		// if true
		return this.diasHabilesPoi.exists[unDia|unDia == unMomento.getDayOfWeek()]
	}

}
