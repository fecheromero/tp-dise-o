package dominio.tiempo

import org.joda.time.LocalTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Turno {
	LocalTime horaInicio
	LocalTime horaFin
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
