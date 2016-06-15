package observer

import dominio.PerfilesDeUsuario.Administrador
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DemoraBusqueda extends Accion {

Administrador admin
double tiempoDeEspera
MailSender mailSender

new(Administrador adm, int tiempo) {
	admin = adm
	tiempoDeEspera = tiempo
}

override buscar(String frase, Long tiempo, int cantidad) {
	if (tiempo / 1000 > tiempoDeEspera){
		mailSender.send(admin)

	}

}
}

/*override buscar(String frase,Long tiempo,int cantidad,PerfilDeUsuario usuario) {
 * 		if((tiempo/1000>tiempoDeEspera)&& (usuario==dueño)){
 * 			mailSender.send(admin)
 * 		}
 } */