package dominio

import org.uqbar.geodds.Point

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet

@Accessors
public class CGP extends PuntoDeInteres {

new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		//this.horario = horarioDeTodosSusServicios(servicios)
	}
	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

	override boolean estaCercaDe(Point coordenadasDestino) {
		this.direccion.comuna.poligono.isInside(coordenadasDestino)
	}

	
}
