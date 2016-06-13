package procesos

import java.util.List
import java.util.ArrayList

class RepositorioProcesos {
	List<ResultadosPorProceso> listaDeResultados=new ArrayList
	
	def agregarResultado(ResultadosPorProceso resultado){
		listaDeResultados.add(resultado)
	}
}