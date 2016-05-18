package observer

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class AlmacenamientoDeBusqueda extends Accion {
	List<ResultadosPorBusqueda> listaDeBusquedas = new ArrayList<ResultadosPorBusqueda>

	override buscar(String frase, Long tiempo, int cantidad) {
		var fechaDeEjecucion = new LocalDate(LocalDate.now.getYear(), LocalDate.now.getMonthOfYear(),
			LocalDate.now.getDayOfMonth())
		var resultado = new ResultadosPorBusqueda(frase, cantidad, tiempo, fechaDeEjecucion)
		listaDeBusquedas.add(resultado)
	}

	def int cantidadDeBusquedasPorFecha(LocalDate fecha) {
		var lista = listaDeBusquedas.filter[unaBusqueda|unaBusqueda.fechaDeConsulta == fecha]
		var cantidad = lista.length
		return cantidad
	}

	def ArrayList<Integer> resultadosParcialesPorTerminal() {
		var listaDeResultados = listaDeBusquedas.map[unaBusqueda|unaBusqueda.cantidadDeResultados]
		return new ArrayList<Integer>(listaDeResultados.toList)
	}

	def int resultadosTotalesPorTerminal() {
		var listaDeResultados = this.resultadosParcialesPorTerminal()
		return listaDeResultados.fold(0, [acum, resultados|acum + resultados])

	}
}
	

/* 
override buscar(String frase,Long tiempo,int cantidad,PerfilDeUsuario usuario) {
		if(dueño==usuario){
		var fechaDeEjecucion = new LocalDate(LocalDate.now.getYear(), LocalDate.now.getMonthOfYear(),
			LocalDate.now.getDayOfMonth())
		var resultado = new ResultadosPorBusqueda(frase,cantidad,tiempo, fechaDeEjecucion,
			usuario)
		listaDeBusquedas.add(resultado)
		}
	}
	 */
	
