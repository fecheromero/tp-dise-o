package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class SucursalBanco extends PuntoDeInteres {
	List<Servicio> servicios

	new(List<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.direccion = _direccion
		this.nombre = _nombre
		this.servicios = servicios

	}
		override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

	override boolean estaDisponible(Momento unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	}

	override boolean estaDisponible(Momento unMomento, String nombreDeServicio) {
		return this.estaDisponible(unMomento)
	}
}
