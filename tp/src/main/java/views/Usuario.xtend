package views

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable 

class Usuario {
	String nombreUsuario
	String contraseña
}