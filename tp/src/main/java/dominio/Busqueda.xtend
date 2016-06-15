package dominio

import dominio.pois.PuntoDeInteres
import java.util.List
import java.util.HashSet
import dependencias.Buscador
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import dominio.PerfilesDeUsuario.PerfilDeUsuario
import observer.Accion

@Accessors
class Busqueda {
	List<Accion> busquedaObservers = new ArrayList<Accion>

	HashSet<OrigenDePois> origenes = new HashSet<OrigenDePois>

	def List<PuntoDeInteres> buscar(String str, PerfilDeUsuario user) {
		
		var tiempoInicio = System.currentTimeMillis()
		val lista = Buscador.getInstance.mostrarPrimeros(str, origenes.map[origen|origen.buscar(str)].flatten.toList,
			10)
		var tiempoFin = System.currentTimeMillis()
		val tiempo = tiempoFin - tiempoInicio
		busquedaObservers.forEach[observador|observador.buscar(str,tiempo,lista.length,user )]
		return lista
	}

	def void agregarObservador(Accion observer) {
		busquedaObservers.add(observer)
	}
	def void eliminarObservador(Accion observer) {
		busquedaObservers.remove(observer)
	}

	def void agregarOrigen(OrigenDePois origen) {
		origenes.add(origen)
	}

}



/* 
def List<PuntoDeInteres> buscar(String str, PerfilDeUsuario usuario) {
		var tiempoInicio = System.currentTimeMillis()
		val lista = Buscador.getInstance.mostrarPrimeros(str, origenes.map[origen|origen.buscar(str)].flatten.toList,
			10)
		var tiempoFin = System.currentTimeMillis()
		val tiempo = tiempoFin - tiempoInicio
//		busquedaObservers.forEach[observador|observador.tiempoDeEjecucion(tiempo)]
//		busquedaObservers.forEach[observador|observador.cantidadDeResultados(lista.length)]
//		busquedaObservers.forEach[observador|observador.ejecutadoPor(usuario)]
		busquedaObservers.forEach[observador|observador.buscar(str,tiempo,lista.length,usuario)]
		return lista
	}
*/