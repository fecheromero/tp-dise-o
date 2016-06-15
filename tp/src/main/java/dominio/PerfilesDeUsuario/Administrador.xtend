package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion

class Administrador extends PerfilDeUsuario{
	
	new(Busqueda busc) {
		buscador=busc
	}

	override estaHabilitadaLaAccion(Accion accion) {
		true
	}

}