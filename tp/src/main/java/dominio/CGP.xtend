package dominio

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class CGP extends PuntoDeInteres {
	List<Servicio> servicios

	new( List<Servicio> servicios,Direccion _direccion,String _nombre) {
		this.direccion=_direccion
		this.nombre=_nombre
		this.servicios = servicios
	}

	override String listaDeTags() {

		super.listaDeTags().concat(servicios.map[servicio|servicio.listaDeTags()].toString())
	}

	override boolean estaCercaDe(Point coordenadasDestino) {
		this.getDireccion.getComuna.getPoligono.isInside(coordenadasDestino)
	}

}
