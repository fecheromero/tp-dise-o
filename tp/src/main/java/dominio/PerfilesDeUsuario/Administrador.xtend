package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion
import procesos.Proceso

class Administrador extends PerfilDeUsuario{
	
	new(Busqueda busc) {
		buscador=busc
	}

	override estaHabilitadaLaAccion(Accion accion) {
		true
	}
	
	def exec(Proceso proceso){
		proceso.exec(this)
	}

}