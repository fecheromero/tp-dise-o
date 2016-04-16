package dominio

import org.uqbar.geodds.Point

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
public class CGP extends PuntoDeInteresConServicios {

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

	override boolean estaCercaDe(Point coordenadasDestino) {
		this.direccion.comuna.poligono.isInside(coordenadasDestino)
	}

	
}
