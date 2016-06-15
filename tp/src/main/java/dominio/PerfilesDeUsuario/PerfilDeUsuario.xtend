package dominio.PerfilesDeUsuario

import dominio.Busqueda
import dominio.pois.PuntoDeInteres
import java.util.ArrayList
import java.util.List
import observer.Accion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public abstract class PerfilDeUsuario {
	Busqueda buscador
	List<Accion> listaDeAcciones = new ArrayList<Accion>
	
	def List<PuntoDeInteres> buscar(String str){
		buscador.buscar(str,this)
	}
	def boolean estaHabilitadaLaAccion(Accion accion)
	
	
	
}

