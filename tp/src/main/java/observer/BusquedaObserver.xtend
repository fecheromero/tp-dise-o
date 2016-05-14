package observer

import dominio.Busqueda

interface BusquedaObserver {
		
	def void buscar(String frase)
	def void tiempoDeEjecucion(Long tiempo)
	def void cantidadDeResultados(Integer cantidad)
	
}