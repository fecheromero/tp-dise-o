package decorator

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Acciones {
	HashMap<String,InterfazDeBusqueda> acciones=new HashMap()
	private static Acciones uno=new Acciones()
		private new( ){
			}
		def public static Acciones getInstance(){
			uno
		}
		def void agregar(String key,InterfazDeBusqueda accion){
			acciones.put(key,accion)
		}
		def void quitar(String key){
			acciones.remove(key)
		}
		def InterfazDeBusqueda accion(String key){
			acciones.get(key)}
		def void  reset(){
			acciones=new HashMap()
		}
	}