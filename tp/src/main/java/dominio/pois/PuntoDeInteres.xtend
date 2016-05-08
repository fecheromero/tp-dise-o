package dominio.pois

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import dependencias.*
import java.util.HashSet
import com.google.common.collect.Sets
import excepciones.NoValidoException
import dominio.tiempo.Horario
import dominio.tiempo.Turno
import dominio.tiempo.Horario.Dia
import dominio.pois.Servicio

@Accessors
public abstract class PuntoDeInteres {
	Direccion direccion
	String nombre
	Horario horario
	HashSet<Servicio> servicios

	var double DISTANCIA_MAXIMA = 0.5

	public def String listaDeTags() {
		nombre.concat(" ").concat(direccion.listaDeTags())
	}

	def boolean estaCercaDe(Point coordenadasDestino) {
		direccion.coordenadas.distance(coordenadasDestino) < DISTANCIA_MAXIMA
	}

	def boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		return this.horario.esHabilElMomento(unMomento)
	}

	def Horario horarioDeTodosSusServicios(HashSet<Servicio> servicios) {
		return new Horario(juntarDiasDeServicios(servicios), juntarTurnosDeServicios(servicios))
	}

	def HashSet<Dia> juntarDiasDeServicios(HashSet<Servicio> servicios) {
		// return Sets.newHashSet(Dia.values.filter[dia|servicios.exists[servicio|servicio.horario.diasHabilesPoi.contains(dia)]])
		return Sets.newHashSet(servicios.map[unServicio|unServicio.horario.diasHabilesPoi].flatten())
	}

	def HashSet<Turno> juntarTurnosDeServicios(HashSet<Servicio> servicios) {
		return Sets.newHashSet(servicios.map[unServicio|unServicio.horario.turnosDisponibles].flatten())
	}


	def void validate() {

		if (PuntoDeInteres.declaredFields.exists [ field |
			field.accessible = true
			field.get(this) == null

		])
			throw new NoValidoException("El Poi no es valido")
		else {
			this.direccion.validate()
		}
	}

}
