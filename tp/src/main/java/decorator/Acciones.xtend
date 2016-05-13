package decorator

import java.util.Map

class Acciones {
	Map<String,InterfazDeBusqueda> acciones
	private static Acciones uno=new Acciones()
		private new( ){
			agregar("RegistrarDeBusqueda",new RegistrarBusqueda())
			agregar("ControlarTardanza",new ControlarTardanza())
		}
		def public static Acciones getInstance(){
			uno
		}
		def void agregar(String key,InterfazDeBusqueda accion){
			acciones.put(key,accion)
		}
		def InterfazDeBusqueda accion(String key){
			acciones.get("key")
		}
	}