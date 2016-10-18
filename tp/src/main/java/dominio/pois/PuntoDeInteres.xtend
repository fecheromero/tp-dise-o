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
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.CollectionTable
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import java.util.Set
import org.hibernate.annotations.CascadeType
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown = true)
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoPoi", discriminatorType=DiscriminatorType.INTEGER)
public abstract class PuntoDeInteres implements Validator {
	@Id
	@GeneratedValue
	private int id
	@Validable
	@OneToOne(cascade=ALL)
	Direccion direccion
	@Validable
	@Column(length=100)
	String nombre
	@ManyToOne()
	Horario horario
	@ManyToMany()
	Set<Servicio> servicios
	
	@CollectionTable(name="Reviews", joinColumns=@JoinColumn(name="poi_id"))
	@Column(name="Reviews")
	ArrayList<Review> reviews=new ArrayList<Review>
	@Column(length=20)
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

	def Horario horarioDeTodosSusServicios(Set<Servicio> servicios) {
		return new Horario(juntarDiasDeServicios(servicios), juntarTurnosDeServicios(servicios))
	}

	def HashSet<Dia> juntarDiasDeServicios(Set<Servicio> servicios) {
		// return Sets.newHashSet(Dia.values.filter[dia|servicios.exists[servicio|servicio.horario.diasHabilesPoi.contains(dia)]])
		return Sets.newHashSet(servicios.map[unServicio|unServicio.horario.diasHabilesPoi].flatten())
	}

	def HashSet<Turno> juntarTurnosDeServicios(Set<Servicio> servicios) {
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
