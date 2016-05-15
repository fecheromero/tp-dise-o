package observer

import org.joda.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadosPorBusqueda {
	String palabra
	int cantidadDeResultados
	Double tiempoDeEjecucion
	LocalDate fechaDeConsulta
	
	new(String unaPalabra,Integer resultados,Double tiempo, LocalDate fecha){
		palabra=unaPalabra
		cantidadDeResultados=resultados
		tiempoDeEjecucion=tiempo
		fechaDeConsulta= fecha
	}
}