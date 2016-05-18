package observer

import dominio.Busqueda
import excepciones.NoValidoException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadosTotales extends Accion {
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	Busqueda buscador
	new(AlmacenamientoDeBusqueda almacenamiento) {
		almacenamientoDeTerminal = almacenamiento
	}

	override buscar(String frase, Long tiempo, int cantidad) {
	}

	def int resultadosTotales() {
		if(buscador.busquedaObservers.contains(this)){
		almacenamientoDeTerminal.resultadosTotalesPorTerminal
		}else{throw new NoValidoException("Esta accion está deshabilitada")}
	}
}
/*override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario) {
 * 	}

 * 	def int resultadosTotales() {
 * 		if (dueño.estaHabilitadaLaAccion(this)) {
 * 			almacenamientoDeTerminal.resultadosTotalesPorTerminal
 * 		} else {
 * 			throw new NoValidoException("Esta accion ya está habilitada")
 } */
