package dominio

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Servicio {
	String nombre
	Horario horario


	new(String _nombre,Horario _horario) {
		this.nombre = _nombre
		this.horario = _horario
	}

	def String listaDeTags() {
		var String lista
		lista = nombre

	}
/*
	def boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	} */
}
