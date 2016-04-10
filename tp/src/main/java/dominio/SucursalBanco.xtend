package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class SucursalBanco extends PuntoDeInteres {
	List<Servicio> servicios

	new(String tipo, List<Servicio> servicios) {
		this.tipo = tipo
		this.servicios = servicios
	}

}
