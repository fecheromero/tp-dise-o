package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class ParadaDeColectivo extends PuntoDeInteres {
	
	new(Direccion _direccion, String _nombre) {
		this.direccion = _direccion
		this.nombre = _nombre
		 DISTANCIA_MAXIMA=0.1
	}

	override estaDisponible(Momento unMomento) {
		return true
	}

	override estaDisponible(Momento unMomento, String nombreDeServicio) {
		return true
	}

}
