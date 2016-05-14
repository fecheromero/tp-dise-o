package observer

import java.util.List
import java.util.ArrayList
import java.util.Map
import java.util.HashMap

class AlmacenamientoDeBusqueda implements BusquedaObserver{
	
	List<ResultadosPorBusqueda> listaDeFrasesBuscadas=new ArrayList<ResultadosPorBusqueda>
	int contador
	double tiempoDeEjecucion
	int cantidadDeResultados

	override buscar(String frase) {
		contador++
		var resultado=new ResultadosPorBusqueda(frase,cantidadDeResultados,tiempoDeEjecucion)
		listaDeFrasesBuscadas.add(resultado)	
	}
	
	override tiempoDeEjecucion(Long tiempo) {
		tiempoDeEjecucion=tiempo
	}
	
	override cantidadDeResultados(Integer cantidad) {
		cantidadDeResultados=cantidad
	}
	
	
	
}