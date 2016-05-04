package dominio

import org.joda.time.LocalTime
import java.util.HashSet
import org.joda.time.DateTime
import dominio.Horario.Dia
import excepciones.NoValidoException

class SucursalBanco extends PuntoDeInteres {

	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		var turnosDisponiblesBanco = new HashSet<Turno>
		var diasHabilesBanco = new HashSet<Dia>
		var turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.VIE)
		this.horario = new Horario(diasHabilesBanco, turnosDisponiblesBanco)
	}


	override boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		(if (nombreDeServicio == "")
			super.estaDisponible(unMomento, nombreDeServicio)
		else {
			if (this.servicios.exists[servicio|servicio.nombre == nombreDeServicio])
				this.servicios.findFirst[servicio|servicio.nombre == nombreDeServicio].estaDisponible(unMomento)
			else {
				throw new NoValidoException("No se encuentra el servicio")
			}

		})
	}

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.nombre].fold("", [ serv1, serv2 |
			serv1.concat(serv2)
		])))
	}

}
