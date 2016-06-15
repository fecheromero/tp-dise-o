package dominio



import java.util.HashSet
import dependencias.Buscador
import org.eclipse.xtend.lib.annotations.Accessors
import decorator.InterfazDeBusqueda
import decorator.Terminal

@Accessors
class Busqueda implements InterfazDeBusqueda {
	HashSet<OrigenDePois> origenes=new HashSet<OrigenDePois>

		def  override buscar(String str, Terminal exec){
				var long starTime=System.nanoTime()
			exec.rdo=Buscador.getInstance.mostrarPrimeros(str,origenes.map[origen| origen.buscar(str)].flatten.toList,10)
				var long endTime=System.nanoTime()
					exec.tardanza=(endTime-starTime)/1000000			
		}
		def void agregarOrigen(OrigenDePois origen){
			origenes.add(origen)
		}
	}