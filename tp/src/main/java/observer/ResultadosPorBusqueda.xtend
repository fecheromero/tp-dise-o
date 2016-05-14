package observer

class ResultadosPorBusqueda {
	String palabra
	int cantidadDeResultados
	Double tiempoDeEjecucion
	
	new(String unaPalabra,Integer resultados,Double tiempo){
		palabra=unaPalabra
		cantidadDeResultados=resultados
		tiempoDeEjecucion=tiempo
	}
}