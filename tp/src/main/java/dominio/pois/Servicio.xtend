package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import dominio.tiempo.Horario
import dependencias.Validable
import dependencias.Validator
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.hibernate.annotations.GenericGenerator

@Accessors
@Observable
@Entity
class Servicio implements Validator {
	@Id
	@GeneratedValue
	private int id
//	@Id
//	@GeneratedValue(generator = "uuid")
//	@GenericGenerator(name = "uuid", strategy = "uuid2")
//	@Validable
	@Column(length=100)
	String nombre
	@Validable
	@ManyToOne(cascade=ALL)
  	Horario horario

	new() {
		
	}
	new(String _nombre,Horario _horario) {
		this.nombre = _nombre
		this.horario = _horario
	}

	override toString(){
		nombre
	}
	def String listaDeTags() {
		var String lista
		lista = nombre

	}

	def boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	} 
}
