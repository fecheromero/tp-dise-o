package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

@Accessors
class Servicio {
	String nombre
	Horario horario
	new(String _nombre){
		nombre=_nombre
	}
	def String listaDeTags() {
		var String lista
		lista = nombre
		
	}
def boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)		 
	}
}
