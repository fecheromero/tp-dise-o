package saludo_de_personas

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Saludo {
	String nombre
	String apellido
	String saludoCompleto
	
	def saludar (){
		saludoCompleto= "Hola"+" "+nombre+" "+apellido
	}
	
	def void setNombre(String nombre){
		this.nombre=nombre
		this.saludar()
	}
	def void setApellido(String apellido){
		this.apellido=apellido
		this.saludar()
	}
		
	
}