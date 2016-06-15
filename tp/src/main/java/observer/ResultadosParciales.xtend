package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import excepciones.NoValidoException
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadosParciales extends Accion {

	override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario user) {}

	def ArrayList<Integer> resultadosParciales(PerfilDeUsuario user) {
		if (user.estaHabilitadaLaAccion(this)) {
			return resultadosParcialesPorTerminal(user)
		} else {
			throw new NoValidoException("Esta accion está deshabilitada")
		}

	}

	def ArrayList<Integer> resultadosParcialesPorTerminal(PerfilDeUsuario terminal) {
		var listaDeBusquedasDeTerminal = RepositorioDeConsultas.getInstance.listaDeBusquedas.filter [unaBusqueda|
			unaBusqueda.usuario == terminal
		]
		var listaDeResultados = listaDeBusquedasDeTerminal.map[unaBusqueda|unaBusqueda.cantidadDeResultados]
		return new ArrayList<Integer>(listaDeResultados.toList)
	}
}

