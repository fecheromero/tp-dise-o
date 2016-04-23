package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
 class KioscoDiarios extends LocalComercial{
	
new(String _nombre,Horario _horario,Direccion _direccion){
		this.horario=_horario
		this.nombre=_nombre
		this.direccion=_direccion
		DISTANCIA_MAXIMA=0.2
		rubro="kiosco"
		
	}
}
