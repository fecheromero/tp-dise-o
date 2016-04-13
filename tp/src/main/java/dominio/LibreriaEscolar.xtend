package dominio

class LibreriaEscolar extends LocalComercial {


	new(String _nombre,Horario _horario,Direccion _direccion){
		this.horario=_horario
		this.nombre=_nombre
		this.direccion=_direccion
		rubro="libreria"
	}
}
