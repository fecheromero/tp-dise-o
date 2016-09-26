package dominio.pois

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.google.common.collect.Sets
import dependencias.Validable
import dependencias.Validator
import dominio.tiempo.Dia
import dominio.tiempo.Horario
import dominio.tiempo.Turno
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import views.BusquedaWindow
import views.MasInfoWindow
import views.ParParametrico

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown = true)
public abstract class PuntoDeInteres implements Validator {
	private int id
	@Validable
	Direccion direccion
	@Validable
	String nombre
	Horario horario
	HashSet<Servicio> servicios
//	String icono
	ArrayList<Review> reviews=new ArrayList<Review>
	var double DISTANCIA_MAXIMA = 0.5
	
	def void agregarReview(Review review){
		reviews.add(review)
	}

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
	
	def List<ParParametrico> parametrosTextBox(){	
	#[]
	}			
	def List<ParParametrico> parametrosCombos(){
		#[]
	}
	
  def mostrar(BusquedaWindow view){
	var ventana=new MasInfoWindow(view,this,this.parametrosTextBox,this.parametrosCombos)
	view.openDialog(ventana)
	
}
	

	/*def void validate() {

		if (PuntoDeInteres.declaredFields.exists [ field |
			field.accessible = true
			field.get(this) == null

		])
			throw new NoValidoException("El Poi no es valido")
		else {
			this.direccion.validate()
		}
	}*/

}
