package dominio


import dominio.pois.PuntoDeInteres
import java.util.List
import java.util.HashSet
import dependencias.Buscador
import org.eclipse.xtend.lib.annotations.Accessors
import observer.BusquedaObserver
import java.util.ArrayList

@Accessors
class Busqueda {
	List<BusquedaObserver> busquedaObservers=new ArrayList<BusquedaObserver>
	
	HashSet<OrigenDePois> origenes=new HashSet<OrigenDePois>
		def List<PuntoDeInteres> buscar(String str){
			var tiempoInicio=System.currentTimeMillis()
			val lista =Buscador.getInstance.mostrarPrimeros(str,origenes.map[origen| origen.buscar(str)].flatten.toList,10)
			var tiempoFin=System.currentTimeMillis()
			val tiempo=tiempoFin-tiempoInicio
			busquedaObservers.forEach [ observador | observador.tiempoDeEjecucion(tiempo) ]
			busquedaObservers.forEach [ observador | observador.cantidadDeResultados(lista.length) ]
			busquedaObservers.forEach [ observador | observador.buscar(str) ]
			return lista		
		}
		def void agregarBusquedaObserver(BusquedaObserver observer){
			busquedaObservers.add(observer)
		}
		def void agregarOrigen(OrigenDePois origen){
			origenes.add(origen)
		}
		
	}