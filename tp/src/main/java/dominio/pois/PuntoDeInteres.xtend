package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors
import dominio.tiempo.Horario
import java.util.HashSet
import org.uqbar.geodds.Point
import org.joda.time.DateTime
import dominio.tiempo.Turno
import dominio.tiempo.Dia
import com.google.common.collect.Sets
import dependencias.Validable
import dependencias.Validator
import org.uqbar.commons.utils.Observable
import views.MasInfoWindow
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.aop.windows.TransactionalDialog
import java.util.List
import views.ParParametrico
import views.BusquedaModel
import views.BusquedaWindow
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

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
	String icono
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
