package dominio.PerfilesDeUsuario

import dominio.Busqueda
import excepciones.NoValidoException
import java.util.ArrayList
import java.util.List
import observer.Accion

class Consulta extends PerfilDeUsuario {
	String nombre
	List<Accion> listaDeAcciones = new ArrayList<Accion>

	new(String nom, Busqueda busc, List<Accion> acciones) {
		buscador = busc
		nombre = nom
		listaDeAcciones = acciones
	}

	def habilitarAccion(Accion accion) {
		if (listaDeAcciones.contains(accion)) {
		throw new NoValidoException("Esta accion ya está habilitada")
		} else if (buscador.busquedaObservers.contains(accion)) {
			listaDeAcciones.add(accion)}
			else {
			throw new NoValidoException("La acción no es valida para esta búsqueda")
		}
	}

	def deshabilitarAccion(Accion accion) {
		if (listaDeAcciones.contains(accion)) {
			listaDeAcciones.remove(accion)
		} else if (buscador.busquedaObservers.contains(accion)) {
			throw new NoValidoException("Esta accion ya está deshabilitada")}
		else { throw new NoValidoException("La acción no es valida para esta búsqueda")
		}
	}

	override estaHabilitadaLaAccion(Accion accion) { return listaDeAcciones.contains(accion) }

}

/*
def int buscarPorFecha(LocalDate fecha){
		var acciones = (listaDeAcciones.filter[unaAccion| unaAccion.getClass == BusquedasPorFecha])
		if ( acciones.empty){
			throw new NoValidoException("Esta accion está deshabilitada")
		}
		else{
		var accion =acciones.get(0)
		return (listaDeAcciones.findFirst[unaAccion| unaAccion.getClass == BusquedasPorFecha]).buscarPorFecha(fecha, this)
		}
	 */	
		
		 