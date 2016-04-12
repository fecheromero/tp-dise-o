package dominio

import org.joda.time.LocalTime

class Turno {
	LocalTime horaInicio
	LocalTime horaFin

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
