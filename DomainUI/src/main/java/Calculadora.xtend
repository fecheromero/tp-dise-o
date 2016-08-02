

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable

class Calculadora {
	double operando1
	double operando2
	double resultado
	
	def calcular(){
		resultado = operando1 + operando2
	}
	
}