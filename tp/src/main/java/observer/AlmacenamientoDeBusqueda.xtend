package observer

import java.util.List
import java.util.ArrayList
import org.joda.time.LocalDate
import dominio.PerfilesDeUsuario.PerfilDeUsuario
import dominio.PerfilesDeUsuario.Consulta
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AlmacenamientoDeBusqueda implements BusquedaObserver {

	List<ResultadosPorBusqueda> listaDeBusquedas = new ArrayList<ResultadosPorBusqueda>
	int contador
	double tiempoDeEjecucion
	int cantidadDeResultados
	PerfilDeUsuario usuario

//	LocalDate fechaDeEjecucion
	override buscar(String frase) {
		contador++
		var fechaDeEjecucion = new LocalDate(LocalDate.now.getYear(), LocalDate.now.getMonthOfYear(),
			LocalDate.now.getDayOfWeek)
		var resultado = new ResultadosPorBusqueda(frase, cantidadDeResultados, tiempoDeEjecucion, fechaDeEjecucion,
			usuario)
		listaDeBusquedas.add(resultado)
	}

	override tiempoDeEjecucion(Long tiempo) {
		tiempoDeEjecucion = tiempo
	}

	override cantidadDeResultados(Integer cantidad) {
		cantidadDeResultados = cantidad
	}

	def int cantidadDeBusquedasPorFecha(LocalDate fecha) {
		var lista = listaDeBusquedas.filter[unaBusqueda|unaBusqueda.fechaDeConsulta == fecha]
		var cantidad = lista.length
		return cantidad
	}

	override ejecutadoPor(PerfilDeUsuario usr) {
		usuario = usr
	}

	def ArrayList<Integer> resultadosParcialesPorTerminal(Consulta usr) {
		var listaPorUsuario = listaDeBusquedas.filter[unaBusqueda|(unaBusqueda.usuario) == usr]
		var listaDeResultados=listaPorUsuario.map[unaBusqueda|unaBusqueda.cantidadDeResultados]
		return new ArrayList<Integer>(listaDeResultados.toList)
	}

	def int ResultadosTotalesPorTerminal(Consulta usr) {
		var listaDeResultados = this.resultadosParcialesPorTerminal(usr)
		return listaDeResultados.fold(0,[acum,resultados|acum+resultados])

	}
}
	

