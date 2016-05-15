package dominio.PerfilesDeUsuario

import dominio.Busqueda
import dominio.pois.PuntoDeInteres
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public abstract class PerfilDeUsuario {
	Busqueda buscador
	def List<PuntoDeInteres> buscar(String str){
		buscador.buscar(str,this)
	}
}