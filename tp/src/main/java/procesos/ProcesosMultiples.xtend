package procesos

import java.util.List
import java.util.ArrayList
import dominio.PerfilesDeUsuario.Administrador


class ProcesosMultiples extends Proceso{
	List<Proceso> listaDeProcesos= new ArrayList
	
	new(List<Proceso> procesos){
		listaDeProcesos=procesos
	}	
	override exec(Administrador adm) {
		listaDeProcesos.forEach[proceso|adm.exec(proceso)]
	
	}
}