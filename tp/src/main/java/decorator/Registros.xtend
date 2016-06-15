package decorator

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashMap

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
		def HashMap<String,Integer> informeCantDeBusquedasXFecha(){
			val HashMap<String,Integer> rdo=new HashMap<String,Integer>
			registros.map[registro|registro.fecha].toSet.forEach[fecha| 
											rdo.put(fecha,cantidadBusquedasPorFecha(fecha))
			]
			rdo
		}
		def int cantDeRdosPorTerminal(Terminal terminal){
			registros.filter[rdo| rdo.term==terminal].map[rdo| rdo.cantDeResultados].fold(0,[cant1,cant2|cant1+cant2])
				
		}
		def HashMap<String,Integer> informeTotalesPorTerminal(){
			val HashMap<String,Integer> rdo=new HashMap<String,Integer>
			registros.map[registros|registros.term].toSet.forEach[terminal| rdo.put(terminal.nombre,cantDeRdosPorTerminal(terminal))]
			rdo		
		}
		def List<Integer> parcialesPorTerminal(Terminal terminal){
			registros.filter[rdo|rdo.term==terminal].map[rdo| rdo.cantDeResultados].toList
		}
		
}
		