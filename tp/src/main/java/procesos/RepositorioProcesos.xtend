package procesos

import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepositorioProcesos {
	List<ResultadosPorProceso> listaDeResultados=new ArrayList
	
	def agregarResultado(ResultadosPorProceso resultado){
		listaDeResultados.add(resultado)
	}
}