package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion
import procesos.Proceso

class Administrador extends PerfilDeUsuario{
	
	new(Busqueda busc) {
		buscador=busc
	}

	override estaHabilitadaLaAccion(Accion accion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def exec(Proceso proceso){
		proceso.exec(this)
	}

}