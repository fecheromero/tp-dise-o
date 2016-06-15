package observer

import dominio.PerfilesDeUsuario.Administrador
import org.eclipse.xtend.lib.annotations.Accessors
import dominio.PerfilesDeUsuario.PerfilDeUsuario

@Accessors
class DemoraBusqueda extends Accion {

Administrador admin
double tiempoDeEspera
MailSender mailSender

new(Administrador adm, int tiempo) {
	admin = adm
	tiempoDeEspera = tiempo
}

override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario user) {
	if (tiempo / 1000 > tiempoDeEspera && (user.estaHabilitadaLaAccion(this))) {
		mailSender.send(admin)

	}

}

}

