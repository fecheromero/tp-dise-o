package decorator

import dominio.Busqueda
import java.util.List
import java.util.ArrayList
import dominio.pois.PuntoDeInteres
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Terminal {
 	List<PuntoDeInteres> rdo
 	InterfazDeBusqueda buscador
 	new(){
		buscador=new Busqueda()
	}
 	long tardanza
 		def void reset(){
 			rdo=null
 			tardanza=0
 		}
 		def List<PuntoDeInteres> buscar(String str){
 			reset
 			buscador.buscar(str,this)
 			rdo
 		}
 		/*def void agregarAccion(String str){
 			var InterfazDeBusqueda accion=Acciones.getInstance().accion(str)
 			var InterfazDeBusqueda iterador=buscador 
 			while(iterador.sig!=accion&&iterador.sig!=null){
 				iterador=iterador.sig()
 			}		
 			if(iterador==null)
 	
 		}
 		def void quitarAccion(String str){}
 		*/
 		//Me faltan estos 2 metodos para habilitar/deshabilitar las acciones
	}