package dominio



import java.util.HashSet
import dependencias.Buscador
import org.eclipse.xtend.lib.annotations.Accessors
import decorator.InterfazDeBusqueda
import decorator.Terminal
import decorator.BusquedaExecuter

@Accessors
class Busqueda implements InterfazDeBusqueda {
	HashSet<OrigenDePois> origenes=new HashSet<OrigenDePois>
		InterfazDeBusqueda sig=null
		def override sig(){
			sig
		}
		def override sig(InterfazDeBusqueda _sig){
	}
		def  override buscar(String str, BusquedaExecuter exec){
				var long starTime=System.nanoTime()
			exec.rdo=Buscador.getInstance.mostrarPrimeros(str,origenes.map[origen| origen.buscar(str)].flatten.toList,10)
				var long endTime=System.nanoTime()
					exec.tardanza=(endTime-starTime)/1000000			
		}
		def void agregarOrigen(OrigenDePois origen){
			origenes.add(origen)
		}
	}