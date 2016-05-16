package dominio.PerfilesDeUsuario

import observer.BusquedaObserver
import dominio.Busqueda

class Administrador extends PerfilDeUsuario{
	
	new(Busqueda busc) {
		buscador=busc
	}
	
	def void elminarAccion(BusquedaObserver observador){
		buscador.eliminarObservador(observador)
	}
	def void agregarAccion(BusquedaObserver observador){
		buscador.agregarObservador(observador)
	}
}