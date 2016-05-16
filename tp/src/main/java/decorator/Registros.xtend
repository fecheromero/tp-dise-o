package decorator

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
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
		
  		def void reset(){
  			registros=new ArrayList<RegistroDeBusqueda>
  		}

		def int cantidadBusquedasPorFecha (String fechaAConsultar){
			var listaBusquedas = registros.filter[registro|registro.fecha == fechaAConsultar]
			var total = listaBusquedas.length
			return total
		}
}
		