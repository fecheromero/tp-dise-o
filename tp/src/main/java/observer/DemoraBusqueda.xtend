package observer

import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.PerfilDeUsuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class DemoraBusqueda implements BusquedaObserver{
	
	Administrador admin
	double tiempoDeEspera
	MailSender mailSender
	
	new(Administrador adm, double tiempo){
		admin=adm
		tiempoDeEspera=tiempo
	}
	override buscar(String frase) {
		}
	
	override tiempoDeEjecucion(Long tiempo) {
		if(tiempo/1000>tiempoDeEspera){
			mailSender.send(admin)
		}
	}
	
	override cantidadDeResultados(Integer cantidad) {
	}
	
	override ejecutadoPor(PerfilDeUsuario usuario) {
	}
	
	
	
}