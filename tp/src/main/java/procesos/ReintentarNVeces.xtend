package procesos

import java.util.List
import java.util.ArrayList


class ReintentarNVeces implements Proceso {
	List<Proceso> listaDeProcesos=new ArrayList
	Integer n
	
	new(List<Proceso> procesos, Integer nVeces){
		listaDeProcesos=procesos
		n=nVeces
		}
		
	override exec (){
		while (n!=0) try{
			listaDeProcesos.forEach[accion |accion.exec()]
			n=0
			}
		catch(Exception e){
		n=n-1
		}
	}
}