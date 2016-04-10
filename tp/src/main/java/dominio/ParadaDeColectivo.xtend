package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class ParadaDeColectivo extends PuntoDeInteres {

	static double DISTANCIA_MAXIMA = 100

	new(Direccion _direccion,String _nombre) {
		this.direccion=_direccion
		this.nombre=_nombre
	}

}
