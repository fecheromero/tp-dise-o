package dominio

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import dependencias.*
import java.util.HashSet
import com.google.common.collect.Sets
import dominio.Horario
import excepciones.NoValidoException
import dominio.Horario.Dia

@Accessors
public abstract class PuntoDeInteres {
	Direccion direccion
	String nombre
	Horario horario
	HashSet<Servicio> servicios
	//HashSet<Dia> diasHabilesPoi

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

	/*def Horario horarioDeTodosSusServicios(HashSet<Servicio> servicios) {
		return new Horario(juntarDiasDeServicios(servicios), juntarTurnosDeServicios(servicios))
	}*/

	/*def HashSet<Dia> juntarDiasDeServicios(HashSet<Servicio> servicios) {
		return Sets.newHashSet(Dia.values.filter[dia|servicios.exists[servicio|servicio.horario.diasHabilesPoi.contains(dia)]])
	 //return Sets.newHashSet(servicios.map[horario.diasHabilesPoi].flatten())
		 }
	def HashSet<Turno> juntarTurnosDeServicios(HashSet<Servicio> servicios) {
		return Sets.newHashSet(servicios.map[horario.turnosDisponibles].flatten())
	}

	def boolean estaDisponibleElServicio(DateTime unMomento, String nombreDeServicio) {
		var horarioServicio = buscarServicioDeNombre(nombreDeServicio).horario
		return horarioServicio.esHabilElMomento(unMomento)
	}

	def Servicio buscarServicioDeNombre(String nombreDeServicio) {
		return (servicios.findFirst[unServicio|unServicio.nombre == nombreDeServicio])
	}*/

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
