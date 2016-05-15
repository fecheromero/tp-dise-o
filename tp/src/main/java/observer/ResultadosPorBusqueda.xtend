package observer

import org.joda.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import dominio.PerfilesDeUsuario.PerfilDeUsuario

@Accessors
class ResultadosPorBusqueda {
	String palabra
	int cantidadDeResultados
	Double tiempoDeEjecucion
	LocalDate fechaDeConsulta
	PerfilDeUsuario usuario
	new(String unaPalabra,Integer resultados,Double tiempo, LocalDate fecha,PerfilDeUsuario usr){
		palabra=unaPalabra
		cantidadDeResultados=resultados
		tiempoDeEjecucion=tiempo
		fechaDeConsulta= fecha
		usuario=usr
	}
}