package dominio.pois

import org.uqbar.geodds.Polygon
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validable
import dependencias.Validator
import org.uqbar.commons.utils.Observable
import com.fasterxml.jackson.annotation.JsonIgnore
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.Transient
import javax.persistence.GeneratedValue

@Accessors
@Observable
@Entity
class Comuna implements Validator {
	@Id
	@GeneratedValue
	int Id
	@Column(length=100)
	@Validable
	String nombre
	@Validable
	@JsonIgnore
	@Transient
	Polygon poligono
	
	new(String nombre, Polygon poligono){
		this.nombre = nombre
		this.poligono = poligono
	}
	
	/*def String listaDeTags(){
		var String lista
		lista=nombre
	}*/
	
	
	
}