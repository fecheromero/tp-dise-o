package dominio.locales

import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Validator
import dependencias.Validable
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.GeneratedValue
import org.hibernate.annotations.GenericGenerator

@Accessors
@Entity
class Rubro implements Validator {
	@Id
	@GeneratedValue()
	int Id
	@Validable
	@Column(length=100)
	String nombre
	@Column()
	var double DISTANCIA_MAXIMA 
	
	new() {
		
	}
	new(String _nombre,Double _distanciamaxima){
		this.nombre=_nombre
		DISTANCIA_MAXIMA = _distanciamaxima
		
		
		
	}
	
	
	
}

