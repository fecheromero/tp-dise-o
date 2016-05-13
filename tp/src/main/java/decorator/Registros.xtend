package decorator

import java.util.ArrayList
import java.util.List

class Registros {
	List<RegistroDeBusqueda> registros=new ArrayList<RegistroDeBusqueda>
		private static Registros uno=new Registros()
		private new( ){}
		def public static Registros getInstance(){
			uno
		}
		def void create(RegistroDeBusqueda reg){
			registros.add(reg)
		}
		def void delete(RegistroDeBusqueda reg){
			registros.dropWhile[elem| elem==reg]
		}
}