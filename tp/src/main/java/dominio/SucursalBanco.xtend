package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class SucursalBanco extends PuntoDeInteres {
	List<Servicio> servicios

	new( List<Servicio> servicios,Direccion _direccion,String _nombre) {
		this.direccion=_direccion
		this.nombre=_nombre
		this.servicios = servicios
		
	}
}
