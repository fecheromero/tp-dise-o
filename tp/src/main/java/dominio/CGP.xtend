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
		return true
	}
	def boolean algunServicioEstaDisponibleEn(Momento unMomento){
		return this.buscarServicioDisponibleEnMomento(unMomento).length > 0 
	}
	
	def List<Servicio> buscarServicioDisponibleEnMomento(Momento unMomento) {
		return servicios.filter[unServicio | unServicio.estaDisponible(unMomento)]
			}
	
}