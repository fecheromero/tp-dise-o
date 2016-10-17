package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import dominio.pois.PuntoDeInteres
import dominio.pois.Direccion
import dependencias.Identificador
import views.MasInfoWindow
import org.uqbar.commons.utils.Observable
import java.util.List
import views.ParParametrico
import org.uqbar.arena.windows.SimpleWindow
import views.BusquedaModel
import views.BusquedaWindow
import java.awt.Panel
import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue

@Observable
@Accessors

@Entity
@DiscriminatorValue("4")
public class ParadaDeColectivo extends PuntoDeInteres {
	
	new(Direccion _direccion, String _nombre) {
		this.direccion = _direccion
		this.nombre = _nombre
		 DISTANCIA_MAXIMA=0.1
		this.id=Identificador.getInstance.nextId
		
	}

	override estaDisponible(DateTime unMomento,String nombreDeServicio){
		return true
	}
	//def override void mostrate(){
	//	new MasInfoWindow(this,#["nombre"]).startApplication
	//}
	/*override validate() {

		if (PuntoDeInteres.declaredFields.filter[field|field.name!="servicios" && field.name!="horario"].exists [ field |
			field.accessible = true
			field.get(this) == null

		])	throw new NoValidoException("El Poi no es valido")
		else {
			this.direccion.validate()
		}


}*/
override parametrosTextBox(){	
	#[new ParParametrico("nombre","nombre")]			
	
	}

@JsonProperty("tipo")
	
	def String tipo() {
		"Colectivo"
	
		}
}
