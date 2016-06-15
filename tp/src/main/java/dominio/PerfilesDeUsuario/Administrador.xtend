package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion
import procesos.Proceso
import procesos.RepositorioProcesos
import procesos.ResultadosPorProceso
import org.joda.time.LocalDateTime



class Administrador extends PerfilDeUsuario{
	RepositorioProcesos repositorio
	Proceso accionDeError
	
	new(Busqueda busc) {
		buscador=busc
	}

	override estaHabilitadaLaAccion(Accion accion) {
		true
	}
	
	def exec(Proceso proceso){
			val inicio=new LocalDateTime
		try{
		val fin1=new LocalDateTime
		repositorio.agregarResultado(new ResultadosPorProceso(inicio,fin1,proceso,this,"ok","correcto"))
	}
		catch(Exception e){
			val fin2= new LocalDateTime
		repositorio.agregarResultado(new ResultadosPorProceso(inicio,fin2,proceso,this,"error","error en "+this.toString))
		
			accionDeError.exec(this)
		}
		
	
	}
}
		

