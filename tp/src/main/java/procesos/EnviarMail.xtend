package procesos

import dominio.PerfilesDeUsuario.Administrador
import observer.MailSender
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EnviarMail implements InterfazProcesoDeError{
Administrador usuario
MailSender mailSender

		new(Administrador _usuario){
			usuario=_usuario
		}
	override exec(Administrador adm, Proceso proceso){
		mailSender.send(usuario)
	
	}
}