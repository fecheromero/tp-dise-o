package observer

class ResultadosTotales extends Accion {
	AlmacenamientoDeBusqueda almacenamientoDeTerminal

	new(AlmacenamientoDeBusqueda almacenamiento) {
		almacenamientoDeTerminal = almacenamiento
	}

	override buscar(String frase, Long tiempo, int cantidad) {
	}

	def int resultadosTotales() {
		almacenamientoDeTerminal.resultadosTotalesPorTerminal
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
