package ejercicio3

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.awt.Color
import org.uqbar.commons.utils.Dependencies

@Accessors
@Observable
class Conversor {
	String oracion
	String oracionInv
	
	int x
	def setOracion(String frase){
		oracion=frase
		this.convertir
	}
	def convertir(){
		oracionInv=""
		for (x=oracion.length()-1; x >=0; x--)
		{
		oracionInv = oracionInv + oracion.charAt(x)
		}
	}

	def esPalindromo(){
		if(oracion==null){
			return false
		}else{
		oracion.equals(oracionInv)
		
		}
	}
	@Dependencies("oracionInv")
	def Color getColor(){
		if(this.esPalindromo){
			return Color.BLUE
		}else{return Color.RED}
	}
}