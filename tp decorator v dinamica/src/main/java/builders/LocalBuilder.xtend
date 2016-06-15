package builders

import dominio.locales.LocalComercial
import dominio.locales.Rubro
import dominio.tiempo.Horario
import dominio.pois.Direccion

class LocalBuilder {
	LocalComercial local
	String nombre
	Rubro rubro
	Horario horario
	Direccion direccion
	
	def LocalBuilder addNombre(String _nombre){
		nombre=_nombre
		this
	}
	def LocalBuilder addRubro(Rubro _rubro){
		rubro=_rubro
		this
	}
	def LocalBuilder addhorario(Horario _horario){
		horario=_horario
		this
	}
	def LocalBuilder addDireccion(Direccion _direccion){
		direccion=_direccion
		this
	}
	def LocalComercial build(){
		local=new LocalComercial(nombre,horario,direccion,rubro)
		local.validate
		local
	}
	}