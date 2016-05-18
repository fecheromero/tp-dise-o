package dominio.PerfilesDeUsuario

import dominio.Busqueda
import observer.Accion
import java.util.List
import java.util.ArrayList
import excepciones.NoValidoException

class Consulta extends PerfilDeUsuario{
	String nombre
//	List<Accion> listaDeAcciones=new ArrayList<Accion>
	
	new(String nom,Busqueda busc,ArrayList<Accion> acciones) {
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