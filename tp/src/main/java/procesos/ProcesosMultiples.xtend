package procesos

import java.util.List
import java.util.ArrayList

class ProcesosMultiples implements Proceso{
	List<Proceso> listaDeProcesos= new ArrayList
	
	new(List<Proceso> procesos){
		listaDeProcesos=procesos
	}	
	override exec() {
		listaDeProcesos.forEach[proceso|proceso.exec()]
	}
	
}