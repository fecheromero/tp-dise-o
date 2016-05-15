package observer

import java.util.List
import java.util.ArrayList
import org.joda.time.LocalDate

class AlmacenamientoDeBusqueda implements BusquedaObserver{
	
	List<ResultadosPorBusqueda> listaDeBusquedas=new ArrayList<ResultadosPorBusqueda>
	int contador
	double tiempoDeEjecucion
	int cantidadDeResultados
//	LocalDate fechaDeEjecucion

	override buscar(String frase) {
		contador++
		var fechaDeEjecucion=new LocalDate(LocalDate.now.getYear(),LocalDate.now.getMonthOfYear(),LocalDate.now.getDayOfWeek)
		var resultado=new ResultadosPorBusqueda(frase,cantidadDeResultados,tiempoDeEjecucion,fechaDeEjecucion)
		listaDeBusquedas.add(resultado)	
	}
	
	override tiempoDeEjecucion(Long tiempo) {
		tiempoDeEjecucion=tiempo
	}
	
	override cantidadDeResultados(Integer cantidad) {
		cantidadDeResultados=cantidad
	}
	
	def int cantidadDeBusquedasPorFecha(LocalDate fecha){
		var lista=listaDeBusquedas.filter[unaBusqueda|unaBusqueda.fechaDeConsulta==fecha]
		var cantidad=lista.length
		return cantidad	
	}
	
	
	
}