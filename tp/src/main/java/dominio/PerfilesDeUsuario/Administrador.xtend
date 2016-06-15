package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion
import procesos.Proceso
import procesos.RepositorioProcesos
import procesos.ResultadosPorProceso
import org.joda.time.LocalDateTime
import procesos.InterfazProcesoDeError
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Administrador extends PerfilDeUsuario{
	RepositorioProcesos repositorio
	InterfazProcesoDeError accionDeError
	new(Busqueda busc) {
		buscador=busc
	}

	override estaHabilitadaLaAccion(Accion accion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def exec(Proceso proceso){
			val inicio=new LocalDateTime
		try{
		val fin1=new LocalDateTime
		proceso.exec(this)
		repositorio.agregarResultado(new ResultadosPorProceso(inicio,fin1,proceso,this,"ok","correcto"))
	}
		catch(Exception e){
			val fin2= new LocalDateTime
		repositorio.agregarResultado(new ResultadosPorProceso(inicio,fin2,proceso,this,"error","error en "+proceso.toString))
		
			accionDeError.exec(this,proceso)
		}
		
	
	}

}