package dominio.tiempo

import org.joda.time.DateTime

import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validator
import dependencias.Validable
import javax.persistence.Entity
import javax.persistence.ManyToMany
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.CollectionTable
import org.hibernate.annotations.CollectionType
import java.util.Set
import javax.persistence.JoinTable
import javax.persistence.JoinColumn
import javax.persistence.Column
import javax.persistence.Enumerated
import javax.persistence.EnumType
import javax.persistence.ElementCollection

//import org.joda.time.Partial
//import org.joda.time.chrono.ISOChronology
//import org.joda.time.DateTimeFieldType

@Accessors
@Entity
public class Horario implements Validator {
	@Id
	@GeneratedValue
	int Id
	@Validable
	@ElementCollection(targetClass=Dia)
	@CollectionTable(name="Dias",joinColumns=@JoinColumn(name="id"))
	@JoinTable(name = "Dia", joinColumns = @JoinColumn(name = "Id"))
	@Column(name ="Dia", nullable = false)
	Set<Dia> diasHabilesPoi
	@Validable
	@ManyToMany(cascade=ALL)
	Set<Turno> turnosDisponibles
	
			
	
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
