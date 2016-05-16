package decorator

import dominio.Busqueda
import java.util.List
import java.util.ArrayList
import dominio.pois.PuntoDeInteres
import org.eclipse.xtend.lib.annotations.Accessors
import java.lang.reflect.Type
import excepciones.NoValidoException

@Accessors
class Terminal extends PerfilDeUsuario {
 	List<PuntoDeInteres> rdo
 	InterfazDeBusqueda buscador
 	public String nombre
 	long tardanza
 	new(String _nombre,Busqueda busqueda){
		buscador=busqueda
		nombre=_nombre
	}
 		def void reset(){
 			rdo=null
 			tardanza=0
 		}
 		def List<PuntoDeInteres> buscar(String str){
 			reset
 			buscador.buscar(str,this)
 			rdo
 		}
 		def void habilitarAccion(String str){
 			var InterfazDeBusqueda accion=Acciones.getInstance().accion(str)
 				if(accion==null){throw new NoValidoException("No se encontro la accion a habilitar")}
 			var InterfazDeBusqueda iterador=buscador
 			var InterfazDeBusqueda ant=null
 			while(( iterador!=null && iterador.class!=accion.class)){ 				
 				ant=iterador
 				iterador=iterador.sig()
 				
 				
 			}		 		
 			if(iterador==null){
  				accion.sig(buscador)
 				buscador=accion
 			}
 			else{if(ant==null){
 				accion.sig(buscador.sig)
 				buscador=accion}
 					else{accion.sig(iterador.sig)
 					ant.sig=accion
 				}
 			}
 				
 			}
 	
 		def void deshabilitarAccion(String str){
 			var InterfazDeBusqueda accion=Acciones.getInstance().accion(str)
 			 				if(accion==null){throw new NoValidoException("No se encontro la accion a deshabilitar")}
 			
 			var InterfazDeBusqueda iterador=buscador
 			var InterfazDeBusqueda ant=null
 			while(iterador!=null&&iterador.class!=accion.class ){
 				ant=iterador
 				iterador=iterador.sig
 			}
 			if(iterador.class==accion.class){
 				if(buscador!=iterador){ant.sig=iterador.sig}
 				else{buscador=buscador.sig}
 			}
 			
 			
 		}
 	
 	
 	
 	}