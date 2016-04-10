package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class KioscoDiarios extends LocalComercial{
	static double DISTANCIA_MAXIMA = 200

	new(String tipo) {
		this.tipo = tipo
	}

}
