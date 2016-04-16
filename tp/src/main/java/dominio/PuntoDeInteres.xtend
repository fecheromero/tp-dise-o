package dominio

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

import org.joda.time.DateTime


@Accessors
public abstract class PuntoDeInteres {

	Direccion direccion
	String nombre
	Horario horario
	var double DISTANCIA_MAXIMA = 0.5

	public def String listaDeTags() {
		var String lista = ""
		lista.concat(#[this.nombre, this.direccion.listaDeTags()].fold("", [ palabra1, palabra2 |
			palabra1.concat(" ").concat(palabra2)
		]))
	}

	def boolean estaCercaDe(Point coordenadasDestino) {
		direccion.coordenadas.distance(coordenadasDestino) < DISTANCIA_MAXIMA
	}
	
		def boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	}
	/*def void elNegocioEstaDisponibleEnUnMomento(DateTime unMomento) {
		if (this.estaDisponible(unMomento))
			System::out.println("Esta Disponible " + this.nombre + " la fecha: "+ unMomento)
		else
			System::out.println("No esta Disponible " + this.nombre + " la fecha: "+ unMomento)
	}
*/
		
}
