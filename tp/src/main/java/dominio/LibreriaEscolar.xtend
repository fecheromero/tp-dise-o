package dominio

class LibreriaEscolar extends LocalComercial {
	static double DISTANCIA_MAXIMA = 500

	new(Direccion _direccion,String _nombre) {
		this.direccion=_direccion
		this.nombre=_nombre
	}
}
