package dominio.PerfilesDeUsuario

import dominio.Busqueda
import excepciones.NoValidoException
import observer.Accion

class Consulta extends PerfilDeUsuario{
	String nombre
//	List<Accion> listaDeAcciones=new ArrayList<Accion>
	
	new(String nom,Busqueda busc) {
		buscador=busc
		nombre=nom
//		listaDeAcciones=acciones
		}
		def habilitarAccion(Accion accion){
		if(buscador.busquedaObservers.contains(accion)){
			throw new NoValidoException("Esta accion ya está habilitada")
		}else{buscador.agregarObservador(accion)}
	}
	def deshabilitarAccion(Accion accion){
		if(buscador.busquedaObservers.contains(accion)){
			buscador.eliminarObservador(accion)
		}else{throw new NoValidoException("Esta accion ya está deshabilitada")}
	}
	override estaHabilitadaLaAccion(Accion accion){
		if(buscador.busquedaObservers.contains(accion)){
			true
		}else{false}
	}
		
}