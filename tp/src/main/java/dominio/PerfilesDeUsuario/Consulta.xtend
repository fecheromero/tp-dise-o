package dominio.PerfilesDeUsuario

import dominio.Busqueda
import excepciones.NoValidoException
import java.util.ArrayList
import java.util.List
import observer.Accion
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet

@Accessors
class Consulta extends PerfilDeUsuario {
	List<Accion> listaDeAcciones = new ArrayList<Accion>

	new(String nom,String psw, Busqueda busc, ArrayList<Accion> acciones) {
		buscador = busc
		nombre = nom
		contraseña=psw
		favoritos=new HashSet<Integer>
		listaDeAcciones = acciones
	}

	def void habilitarAccion(Accion accion) {
		if (listaDeAcciones.contains(accion)) {
			throw new NoValidoException("Esta accion ya está habilitada")
		} else if (buscador.busquedaObservers.contains(accion)) {
			listaDeAcciones.add(accion)
		} else {
			buscador.busquedaObservers.add(accion)
			this.habilitarAccion(accion)
		}
	}

	def deshabilitarAccion(Accion accion) {
		if (listaDeAcciones.contains(accion)) {
			listaDeAcciones.remove(accion)
		} else if (buscador.busquedaObservers.contains(accion)) {
			throw new NoValidoException("Esta accion ya está deshabilitada")
		} else {
			throw new NoValidoException("La acción no es valida para esta búsqueda")
		}
	}

	override estaHabilitadaLaAccion(Accion accion) {
		return listaDeAcciones.contains(accion)
	}

}
/*
 * def int buscarPorFecha(LocalDate fecha){
 * 		var acciones = (listaDeAcciones.filter[unaAccion| unaAccion.getClass == BusquedasPorFecha])
 * 		if ( acciones.empty){
 * 			throw new NoValidoException("Esta accion está deshabilitada")
 * 		}
 * 		else{
 * 		var accion =acciones.get(0)
 * 		return (listaDeAcciones.findFirst[unaAccion| unaAccion.getClass == BusquedasPorFecha]).buscarPorFecha(fecha, this)
 * 		}
 */
