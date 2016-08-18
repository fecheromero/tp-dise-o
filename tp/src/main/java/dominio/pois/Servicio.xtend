package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import dominio.tiempo.Horario
import dependencias.Validable
import dependencias.Validator
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Servicio implements Validator {
	@Validable
	String nombre
	@Validable
	Horario horario


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
