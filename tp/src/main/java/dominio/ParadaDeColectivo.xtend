package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class ParadaDeColectivo extends PuntoDeInteres {

	static double DISTANCIA_MAXIMA = 100

	new(String tipo) {
		this.tipo = tipo
	}

}
