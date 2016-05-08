package dominio.pois

import org.uqbar.geodds.Point

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet
import dominio.pois.Servicio
import org.joda.time.DateTime
import excepciones.NoValidoException
import dominio.pois.PuntoDeInteres
import dominio.pois.Direccion


@Accessors
public class CGP extends PuntoDeInteres {

	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		this.horario = horarioDeTodosSusServicios(servicios)
	}

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.nombre].fold("", [ serv1, serv2 |
			serv1.concat(serv2)
		])))
	}

	override boolean estaCercaDe(Point coordenadasDestino) {
		this.direccion.comuna.poligono.isInside(coordenadasDestino)
	}

	override boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		if (nombreDeServicio == "")
			super.estaDisponible(unMomento, nombreDeServicio)
		else {
			if (this.servicios.exists[servicio|servicio.nombre == nombreDeServicio])
				this.servicios.findFirst [ servicio |
					servicio.nombre == nombreDeServicio
				].estaDisponible(unMomento)
			else {
				throw new NoValidoException("No se encuentra el servicio")
			}

		}
	}

}
