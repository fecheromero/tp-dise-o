package builders

import dominio.pois.CGP
import dominio.pois.Direccion
import dominio.pois.Servicio
import dominio.tiempo.Horario
import java.util.HashSet

class CGPBuilder {
	CGP cgp
	String nombre
	HashSet<Servicio> servicios=new HashSet<Servicio>
	Horario horario
	
	Direccion direccion
	
	def CGPBuilder addNombre(String _nombre){
		nombre=_nombre
		this
	}
	def CGPBuilder addservicio(Servicio servicio){
		servicios.add(servicio)
		this
	}
	def CGPBuilder addhorario(Horario _horario){
		horario=_horario
		this
	}
	def CGPBuilder addDireccion(Direccion _direccion){
		direccion=_direccion
		this
	}
	def CGP build(){
	 cgp=new CGP(servicios,direccion,nombre)
	 cgp.validate
	 cgp
												  	
	}
	}