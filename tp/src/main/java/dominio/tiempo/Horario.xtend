package dominio.tiempo

import org.joda.time.DateTime
import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validator
import dependencias.Validable

//import org.joda.time.Partial
//import org.joda.time.chrono.ISOChronology
//import org.joda.time.DateTimeFieldType

@Accessors
public class Horario implements Validator {
	@Validable
	HashSet<Dia> diasHabilesPoi
	@Validable
	HashSet<Turno> turnosDisponibles
	
			
	
	new(HashSet<Dia> _diashabiles, HashSet<Turno> _turnos) {
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
		return this.diasHabilesPoi.map[dia|dia.num].exists[dia|dia==(unMomento.getDayOfWeek())]
	}

}
