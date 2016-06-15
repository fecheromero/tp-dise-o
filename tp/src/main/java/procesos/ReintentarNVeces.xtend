package procesos

import java.util.List
import java.util.ArrayList
import dominio.PerfilesDeUsuario.Administrador

class ReintentarNVeces extends Proceso {
	List<Proceso> listaDeProcesos=new ArrayList
	Integer n
	
	new(List<Proceso> procesos, Integer nVeces){
		listaDeProcesos=procesos
		n=nVeces
		}
		
	override exec (Administrador adm){
		while (n!=0) try{
			listaDeProcesos.forEach[accion |adm.exec(accion)]
			n=0
			}
		catch(Exception e){
		n=n-1
		}
	}
}