package observer

import dominio.Busqueda
import dominio.PerfilesDeUsuario.PerfilDeUsuario

interface BusquedaObserver {
		
	def void buscar(String frase)
	def void tiempoDeEjecucion(Long tiempo)
	def void cantidadDeResultados(Integer cantidad)
	def void ejecutadoPor(PerfilDeUsuario usuario)
	
}