package observer

import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.PerfilDeUsuario

class DemoraBusqueda implements BusquedaObserver{
	
	Administrador admin
	double tiempoDeEspera
	
	new(Administrador adm, double tiempo){
		admin=adm
		tiempoDeEspera=tiempo
	}
	override buscar(String frase) {
		}
	
	
		
	def void mandarMailA(Administrador adm){
		
	}
	
	override tiempoDeEjecucion(Long tiempo) {
		if(tiempo>tiempoDeEspera){
			mandarMailA(admin)
		}
	}
	
	override cantidadDeResultados(Integer cantidad) {
	}
	
	override ejecutadoPor(PerfilDeUsuario usuario) {
	}
	
	
	
}