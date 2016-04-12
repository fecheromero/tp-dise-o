package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class KioscoDiarios extends LocalComercial{
	
	new(Direccion _direccion,String _nombre)
	{
		this.direccion=_direccion
		this.nombre=_nombre
		 DISTANCIA_MAXIMA=0.2
	}

}
