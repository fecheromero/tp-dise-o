package procesos

import java.util.List
import java.util.ArrayList

class ProcesosMultiples implements Proceso{
	List<Proceso> listaDeProcesos= new ArrayList
	Proceso accionDeError
	
	new(List<Proceso> procesos){
		listaDeProcesos=procesos
	}	
	override exec() {
		try{
		listaDeProcesos.forEach[proceso|proceso.exec()]
	}
		catch(Exception e){
			accionDeError.exec()
		}
		
	
	}
}