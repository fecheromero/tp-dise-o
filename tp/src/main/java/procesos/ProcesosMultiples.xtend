package procesos

import java.util.List
import java.util.ArrayList
import dominio.PerfilesDeUsuario.Administrador
import org.joda.time.LocalDateTime

class ProcesosMultiples extends Proceso{
	List<Proceso> listaDeProcesos= new ArrayList
	Proceso accionDeError
	
	new(List<Proceso> procesos){
		listaDeProcesos=procesos
	}	
	override exec(Administrador adm) {
		val inicio=new LocalDateTime
		try{
		listaDeProcesos.forEach[proceso|proceso.exec(adm)]
		val fin1=new LocalDateTime
		repositorio.agregarResultado(new ResultadosPorProceso(inicio,fin1,this,adm,"ok","correcto"))
	}
		catch(Exception e){
			val fin2= new LocalDateTime
		repositorio.agregarResultado(new ResultadosPorProceso(inicio,fin2,this,adm,"error","error en "+this.toString))
		
			accionDeError.exec(adm)
		}
		
	
	}
}