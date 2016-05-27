package dominio.pois

import org.joda.time.LocalTime
import java.util.HashSet
import org.joda.time.DateTime
import dominio.tiempo.Dia
import excepciones.NoValidoException
import dominio.tiempo.Turno
import dominio.tiempo.Horario
import dominio.pois.PuntoDeInteres
import dominio.pois.Servicio
import dominio.pois.Direccion
import dependencias.Validable
import dependencias.Identificador

class SucursalBanco extends PuntoDeInteres {
	@Validable
	HashSet<Servicio> servicios
	@Validable
	Horario horario
	 def void sethorario(Horario _horario){
		super.horario=_horario
		horario=_horario
	}
	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		var turnosDisponiblesBanco = new HashSet<Turno>
		var diasHabilesBanco = new HashSet<Dia>
		var turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.VIE)
		this.sethorario(new Horario(diasHabilesBanco, turnosDisponiblesBanco))
		this.id=Identificador.getInstance.nextId
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
