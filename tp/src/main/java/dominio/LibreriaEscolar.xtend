package dominio

class LibreriaEscolar extends LocalComercial {

	new(Direccion _direccion,String _nombre) {
		this.direccion=_direccion
		this.nombre=_nombre
		rubro="libreria"
	}
	
	new(String _nombre,Horario _horario,Direccion _direccion){
		this.horario=_horario
		this.nombre=_nombre
		this.direccion=_direccion
		
	}
}
