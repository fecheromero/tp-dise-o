package dominio.locales

import org.eclipse.xtend.lib.annotations.Accessors
import dominio.tiempo.Horario 
import dominio.pois.PuntoDeInteres
import dominio.pois.Direccion
import dependencias.Validable
import dependencias.Identificador
import views.ParParametrico
import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import javax.persistence.ManyToOne

@Accessors
@Entity
@DiscriminatorValue("1")
public class LocalComercial extends PuntoDeInteres {
	@Validable
	@ManyToOne(cascade=ALL)
	Rubro rubro
	@Validable
	@ManyToOne()
	Horario horario
	
	String otrosTags=""
	
	 def void sethorario(Horario _horario){
		super.horario=_horario
		horario=_horario
	}
	override String listaDeTags() {
		super.listaDeTags().concat(" ".concat(rubro.nombre).concat(" ").concat(otrosTags))
	}
	new() {
		
	}
	new(String _nombre, Horario _horario, Direccion _direccion, Rubro _rubro){
		this.nombre = _nombre
		this.sethorario(_horario)
		this.direccion=_direccion
		rubro=_rubro 
		this.id=Identificador.getInstance.nextId
		
	}
	
	override parametrosTextBox(){
		#[new ParParametrico("direccion","direccion.direccionS"),new ParParametrico("nombre","nombre"),new ParParametrico("rubro","rubro.nombre")]
	}
	@JsonProperty("tipo")
	
	def String tipo() {
		"LocalComercial"
	
		}
	/*override validate() {

		if (PuntoDeInteres.declaredFields.filter[field|field.name!="servicios"].exists [ field |
			field.accessible = true
			field.get(this) == null

		])	throw new NoValidoException("El Poi no es valido")
		else {
			this.direccion.validate()
		}
	
}*/
}