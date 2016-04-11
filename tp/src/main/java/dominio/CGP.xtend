package dominio

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class CGP extends PuntoDeInteres {
	List<Servicio> servicios

	new(List<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.direccion = _direccion
		this.nombre = _nombre
		this.servicios = servicios
	}

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.listaDeTags()].toString()))
	}

	override boolean estaCercaDe(Point coordenadasDestino) {
		this.direccion.comuna.poligono.isInside(coordenadasDestino)
	}

	override boolean estaDisponible(Momento unMomento) {
		return algunServicioEstaDisponibleEn(unMomento)
	}

	override boolean estaDisponible(Momento unMomento, String nombreDeServicio) {
		return estaDisponibleElServicio(unMomento, nombreDeServicio)
	}

	def boolean algunServicioEstaDisponibleEn(Momento unMomento) {
		return servicios.exists[unServicio|unServicio.estaDisponible(unMomento)]
	}

	def boolean estaDisponibleElServicio(Momento unMomento, String nombreDeServicio) {
		return (buscarServicioDeNombre(nombreDeServicio).estaDisponible(unMomento))
	}

	def Servicio buscarServicioDeNombre(String nombreDeServicio) {
		return (servicios.findFirst[unServicio|unServicio.nombre == nombreDeServicio])
	}
}
