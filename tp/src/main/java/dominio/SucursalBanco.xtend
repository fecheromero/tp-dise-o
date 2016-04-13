package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.joda.time.DateTime
import java.util.Set
import org.joda.time.LocalTime
import java.util.HashSet

@Accessors
class SucursalBanco extends PuntoDeInteres {
	HashSet<Servicio> servicios
	Turno turnoBanco
	Horario horarioBancario
	HashSet<Turno> turnosDisponiblesBanco
	HashSet<Integer> diasHabilesBanco

	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.direccion = _direccion
		this.nombre = _nombre
		this.servicios = servicios
		
		
		turnosDisponiblesBanco = new HashSet<Turno>
		diasHabilesBanco = new HashSet<Integer>
		turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(1, 2, 3, 4, 5)
		horarioBancario = new Horario(diasHabilesBanco, turnosDisponiblesBanco)

	}

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

	override boolean estaDisponible(DateTime unMomento) {
		return this.horarioBancario.esHabilElMomento(unMomento)
	}

}
