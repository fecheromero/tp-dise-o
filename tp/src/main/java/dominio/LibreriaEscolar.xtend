package dominio

class LibreriaEscolar extends LocalComercial {

	new(Direccion _direccion,String _nombre) {
		this.direccion=_direccion
		this.nombre=_nombre
		rubro="libreria"
	}
}
