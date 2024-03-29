package procesos

import java.util.List
import java.util.ArrayList
import dominio.PerfilesDeUsuario.Administrador

class ReintentarNVeces implements InterfazProcesoDeError {
	List<Proceso> listaDeProcesos=new ArrayList
	Integer n
	
	new(List<Proceso> procesos, Integer nVeces){
		listaDeProcesos=procesos
		n=nVeces
		}
		
	override exec (Administrador adm, Proceso proceso){
		while (n!=0) try{
			listaDeProcesos.forEach[accion |adm.exec(accion)]
			n=0
			}
		catch(Exception e){
		n=n-1
		}
	}
}