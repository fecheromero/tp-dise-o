package observer

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class RegistroPorBusqueda {
	String palabra
	int cantidadDeResultados
	double tiempoDeEjecucion
	LocalDate fechaDeConsulta
	

	new(String unaPalabra, Integer resultados, long tiempo, LocalDate fecha) {
		palabra = unaPalabra
		cantidadDeResultados = resultados
		tiempoDeEjecucion = tiempo/1000
		fechaDeConsulta = fecha

	}
}
/*new(String unaPalabra,Integer resultados,long tiempo, LocalDate fecha,PerfilDeUsuario usr){
 * 		palabra=unaPalabra
 * 		cantidadDeResultados=resultados
 * 		tiempoDeEjecucion=tiempo
 * 		fechaDeConsulta= fecha
 * 		usuario=usr
 } */
