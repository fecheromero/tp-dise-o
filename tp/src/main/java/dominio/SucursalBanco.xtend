package dominio


import org.joda.time.LocalTime
import java.util.HashSet
import org.joda.time.DateTime

class SucursalBanco extends PuntoDeInteresConServicios {
	HashSet<Servicio> servicios
		
	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		super(servicios, _direccion, _nombre)
		var turnosDisponiblesBanco = new HashSet<Turno>
		var diasHabilesBanco = new HashSet<Integer>
		var turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(1, 2, 3, 4, 5)
		this.horario = new Horario(diasHabilesBanco, turnosDisponiblesBanco)

	}
	override boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		return this.estaDisponible(unMomento)
	}

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

}
