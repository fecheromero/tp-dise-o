package dominio.tiempo

import org.joda.time.LocalTime
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validator
import dependencias.Validable
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Accessors
@Entity
class Turno implements Validator {
	@Validable
	@Id
	@GeneratedValue
	int Id
	@Column()
	LocalTime horaInicio
	@Validable
	@Column()
	LocalTime horaFin
	
	new() {
		
	}
	new(LocalTime _horaInicio,LocalTime _horaFin){
		this.horaInicio=_horaInicio
		this.horaFin=_horaFin
	}

	def boolean horaDentroDelTurno(LocalTime unaHora) {
		return (esMayorHoraInicio(unaHora) && esMenorHoraFin(unaHora))
	}

	def boolean esMayorHoraInicio(LocalTime unaHora) {
		return (unaHora.getMillisOfDay() > this.horaInicio.getMillisOfDay())
	}

	def boolean esMenorHoraFin(LocalTime unaHora) {
		return (unaHora.getMillisOfDay() < this.horaFin.getMillisOfDay())
	}
}
