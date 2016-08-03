package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Accion {
	
	def void buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario)

}
