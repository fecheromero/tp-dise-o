package dominio

import org.eclipse.xtend.lib.annotations.Accessors

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
override boolean estaDisponible(Momento unMomento) {
		return (unMomento) != null 
		 
	}
}
