package procesos

import dominio.PerfilesDeUsuario.Administrador
import observer.MailSender

class EnviarMail extends Proceso{
Administrador usuario
MailSender mailSender

		new(Administrador _usuario){
			usuario=_usuario
		}
	override exec(Administrador adm){
		mailSender.send(usuario)
	
	}
}