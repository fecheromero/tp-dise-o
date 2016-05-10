package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import dominio.tiempo.Horario
import dependencias.ValidableObject
import dependencias.Validable

@Accessors
class Servicio extends ValidableObject {
	@Validable
	String nombre
	@Validable
	Horario horario


	new(String _nombre,Horario _horario) {
		this.nombre = _nombre
		this.horario = _horario
	}

	def String listaDeTags() {
		var String lista
		lista = nombre

	}

	def boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	} 
}
