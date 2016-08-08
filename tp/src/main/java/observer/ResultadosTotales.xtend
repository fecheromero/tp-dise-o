package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import excepciones.NoValidoException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadosTotales extends Accion {

	override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario user) {}

	def int resultadosTotales(PerfilDeUsuario user) {
		if (user.estaHabilitadaLaAccion(this)) {
			return resultadosTotalesPorTerminal(user)
		} else {
			throw new NoValidoException("Esta accion está deshabilitada")
		}

	}

	def int resultadosTotalesPorTerminal(PerfilDeUsuario terminal) {
		var listaDeBusquedasDeTerminal = RepositorioDeConsultas.getInstance.listaDeBusquedas.filter [unaBusqueda|
			unaBusqueda.usuario == terminal
		]
		return listaDeBusquedasDeTerminal.fold(0, [acum, resultado|acum + resultado.cantidadDeResultados])
	}
}
