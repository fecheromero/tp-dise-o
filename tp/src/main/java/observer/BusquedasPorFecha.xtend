package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import org.joda.time.LocalDate
import excepciones.NoValidoException

class BusquedasPorFecha extends Accion {
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	new (AlmacenamientoDeBusqueda almacenamiento){
		almacenamientoDeTerminal=almacenamiento
	}
	override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario) {
	}
	def int busquedasPorFecha(LocalDate fecha){
		if(dueño.estaHabilitadaLaAccion(this)){
		almacenamientoDeTerminal.cantidadDeBusquedasPorFecha(fecha)
		}else{throw new NoValidoException("Esta accion está habilitada")}
	}	
}