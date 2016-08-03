package observer

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate
import dominio.PerfilesDeUsuario.PerfilDeUsuario

@Accessors
class RegistroPorBusqueda {
	String palabra
	int cantidadDeResultados
	double tiempoDeEjecucion
	LocalDate fechaDeConsulta
	PerfilDeUsuario usuario
	

	new(String unaPalabra, Integer resultados, long tiempo, LocalDate fecha, PerfilDeUsuario user) {
		palabra = unaPalabra
		cantidadDeResultados = resultados
		tiempoDeEjecucion = tiempo / 1000
		fechaDeConsulta = fecha
		usuario = user

	}

}
