package dominio


import dominio.pois.PuntoDeInteres
import java.util.List
import java.util.HashSet
import dependencias.Buscador
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Busqueda {
	HashSet<OrigenDePois> origenes=new HashSet<OrigenDePois>
		def List<PuntoDeInteres> buscar(String str){
			Buscador.getInstance.mostrarPrimeros(str,origenes.map[origen| origen.buscar(str)].flatten.toList,10)
		}
		def void agregarOrigen(OrigenDePois origen){
			origenes.add(origen)
		}
	}