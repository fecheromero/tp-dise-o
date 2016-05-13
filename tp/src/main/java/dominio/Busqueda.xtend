package dominio



import java.util.HashSet
import dependencias.Buscador
import org.eclipse.xtend.lib.annotations.Accessors
import decorator.InterfazDeBusqueda
import decorator.Terminal

@Accessors
class Busqueda implements InterfazDeBusqueda {
	HashSet<OrigenDePois> origenes=new HashSet<OrigenDePois>
		InterfazDeBusqueda sig=null
		def override sig(){
			sig
		}
		def override sig(InterfazDeBusqueda _sig){
	}
		def  override buscar(String str, Terminal terminal){
				var long starTime=System.nanoTime()
			terminal.rdo=Buscador.getInstance.mostrarPrimeros(str,origenes.map[origen| origen.buscar(str)].flatten.toList,10)
				var long endTime=System.nanoTime()
					terminal.tardanza=(endTime-starTime)/1000000			
		}
		def void agregarOrigen(OrigenDePois origen){
			origenes.add(origen)
		}
	}