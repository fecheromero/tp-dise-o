package procesos

import dominio.PerfilesDeUsuario.Administrador
import observer.MailSender

class EnviarMail implements Proceso{
Administrador usuario
MailSender mailSender

		new(Administrador _usuario){
			usuario=_usuario
		}
	override exec(){
		mailSender.send(usuario)
	
	}
}