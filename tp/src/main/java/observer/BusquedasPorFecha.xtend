package observer

import org.joda.time.LocalDate
import excepciones.NoValidoException
import dominio.Busqueda
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedasPorFecha extends Accion {
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	Busqueda buscador
	new (AlmacenamientoDeBusqueda almacenamiento){
		almacenamientoDeTerminal=almacenamiento
	}
	override buscar(String frase, Long tiempo, int cantidad) {
	}
	def int busquedasPorFecha(LocalDate fecha){
		if(buscador.busquedaObservers.contains(this)){
		almacenamientoDeTerminal.cantidadDeBusquedasPorFecha(fecha)
		}else{throw new NoValidoException("Esta accion está deshabilitada")}
	}	
}

/*override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario) {
	}
	def int busquedasPorFecha(LocalDate fecha){
		if(dueño.estaHabilitadaLaAccion(this)){
		almacenamientoDeTerminal.cantidadDeBusquedasPorFecha(fecha)
		}else{throw new NoValidoException("Esta accion está habilitada")}
	}	 */