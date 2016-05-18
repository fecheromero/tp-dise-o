package observer

import org.joda.time.LocalDate

class BusquedasPorFecha extends Accion {
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	new (AlmacenamientoDeBusqueda almacenamiento){
		almacenamientoDeTerminal=almacenamiento
	}
	override buscar(String frase, Long tiempo, int cantidad) {
	}
	def int busquedasPorFecha(LocalDate fecha){
		almacenamientoDeTerminal.cantidadDeBusquedasPorFecha(fecha)
		}	
}

/*override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario) {
	}
	def int busquedasPorFecha(LocalDate fecha){
		if(dueño.estaHabilitadaLaAccion(this)){
		almacenamientoDeTerminal.cantidadDeBusquedasPorFecha(fecha)
		}else{throw new NoValidoException("Esta accion está habilitada")}
	}	 */