package procesos

import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

class RepositorioProcesos {
@Accessors
	
	List<ResultadosPorProceso> listaDeResultados=new ArrayList
	private static RepositorioProcesos uno=new RepositorioProcesos()
		private new( ){}
		def public static RepositorioProcesos getInstance(){
			uno
		}
		def void reset(){
		listaDeResultados.clear
		}
		def agregarResultado(ResultadosPorProceso resultado){
		listaDeResultados.add(resultado)
		}
}