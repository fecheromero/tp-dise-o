package dominio

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.lang.reflect.Array
import java.util.ArrayList
import java.util.HashSet
import org.joda.time.DateTime
import java.util.Set

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
	def void elNegocioEstaDisponibleEnUnMomento(DateTime unMomento) {
		if (this.estaDisponible(unMomento))
			System::out.println("Esta Disponible " + this.nombre)
		else
			System::out.println("No esta Disponible " + this.nombre)
	}

	def boolean estaDisponible(DateTime unMomento)

		def void setearDiasHabiles(Set<Integer> diasHabiles) {
		this.horario.setearDiasHabiles(diasHabiles)
	}

	def void setearTurnosDisponibles(Set<Turno> turnos) {
		this.horario.setearTurnosDisponibles(turnos)
	}

}
