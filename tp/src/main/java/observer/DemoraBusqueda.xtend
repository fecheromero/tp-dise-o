package observer

import dominio.PerfilesDeUsuario.Administrador

class DemoraBusqueda implements BusquedaObserver{
	
	Administrador admin
	double tiempoDeEspera
	
	
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
	
	
	
}