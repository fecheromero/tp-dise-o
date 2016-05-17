package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion

class Administrador extends PerfilDeUsuario{
	
	new(Busqueda busc) {
		buscador=busc
	}
	
	override estaHabilitadaLaAccion(Accion accion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}