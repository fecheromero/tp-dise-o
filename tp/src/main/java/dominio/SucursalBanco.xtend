package dominio


import org.joda.time.LocalTime
import java.util.HashSet
import org.joda.time.DateTime
import dominio.Horario.Dia

class SucursalBanco extends PuntoDeInteres {
	HashSet<Servicio> servicios
		
	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		var turnosDisponiblesBanco = new HashSet<Turno>
		var diasHabilesBanco = new HashSet<Dia>
		var turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(Dia.LUN,Dia.MAR,Dia.MIE,Dia.JUE,Dia.VIE)
		//this.horario = new Horario(diasHabilesBanco, turnosDisponiblesBanco)

	}
	override boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		return this.horario.esHabilElMomento(unMomento) && estaDisponibleElServicio(unMomento, nombreDeServicio)
	}

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

}
