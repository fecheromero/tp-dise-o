package dominio.PerfilesDeUsuario

import observer.BusquedaObserver

class Administrador extends PerfilDeUsuario{
	
	def void elminarAccion(BusquedaObserver observador){
		buscador.eliminarObservador(observador)
	}
	def void agregarAccion(BusquedaObserver observador){
		buscador.agregarObservador(observador)
	}
}