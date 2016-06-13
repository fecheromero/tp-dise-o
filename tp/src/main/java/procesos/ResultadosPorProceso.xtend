package procesos

import org.joda.time.LocalDateTime
import dominio.PerfilesDeUsuario.PerfilDeUsuario
class ResultadosPorProceso {
	LocalDateTime fechaInicio
	LocalDateTime fechaFin
	Proceso proceso
	PerfilDeUsuario usuario
	String resultado
	String mensaje
	
	new (LocalDateTime inicio,LocalDateTime fin,Proceso _proceso,PerfilDeUsuario _usuario,String _resultado,String _mensaje){
		fechaInicio=inicio
		fechaFin=fin
		proceso= _proceso
		usuario= _usuario
		resultado= _resultado
		mensaje=_mensaje
	}
}