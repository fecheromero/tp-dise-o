package dominio

import org.joda.time.DateTime

import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
//import org.joda.time.Partial
//import org.joda.time.chrono.ISOChronology
//import org.joda.time.DateTimeFieldType

@Accessors
public class Horario {
	//HashSet<Integer> diasHabilesPoi
	HashSet<Dia> diasHabilesPoi
	public enum Dia {LUN,MAR,MIE,JUE,VIE,SAB,DOM}
	HashSet<Turno> turnosDisponibles
	
	def int transformarANum(Dia unDia){
		switch(unDia){
			case LUN:1
			case MAR:2
			case MIE:3
			case JUE:4
			case VIE:5
			case SAB:6
			case DOM:7
			}
			
	}
	
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
		return this.diasHabilesPoi.map[dia|transformarANum(dia)].exists[dia|dia==(unMomento.getDayOfWeek())]
	}

}
