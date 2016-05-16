package dominio.PerfilesDeUsuario

import dominio.Busqueda

class Consulta extends PerfilDeUsuario{
	String nombre
	new(String nom,Busqueda busc) {
		buscador=busc
		nombre=nom
	}
	
}