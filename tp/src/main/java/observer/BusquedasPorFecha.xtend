package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import excepciones.NoValidoException
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
public class BusquedasPorFecha extends Accion {

	override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario user) {}

	def int buscarPorFecha(LocalDate fecha, PerfilDeUsuario user) {
		if (user.estaHabilitadaLaAccion(this)) {
			return cantidadDeBusquedasPorFecha(fecha)
		} else {
			throw new NoValidoException("Esta accion está Deshabilitada")
		}
	}


	def int cantidadDeBusquedasPorFecha(LocalDate fecha) {
		var lista = RepositorioDeConsultas.getInstance.listaDeBusquedas.filter [unaBusqueda|
			unaBusqueda.fechaDeConsulta == fecha
		]
		var cantidad = lista.length
		return cantidad
	}

}