package observer


import java.util.ArrayList
import dominio.Busqueda
import excepciones.NoValidoException
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ResultadosParciales extends Accion{
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	Busqueda buscador
	new (AlmacenamientoDeBusqueda almacenamiento){
		almacenamientoDeTerminal=almacenamiento
	}
	override buscar(String frase, Long tiempo, int cantidad) {
	}
	def ArrayList<Integer> resultadosParciales(){
		if(buscador.busquedaObservers.contains(this)){
		
		almacenamientoDeTerminal.resultadosParcialesPorTerminal()
		}else{throw new NoValidoException("Esta accion está deshabilitada")}
	}	
}


/*
override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario) {
	}
	def ArrayList<Integer> resultadosParciales(){
		if (dueño.estaHabilitadaLaAccion(this)) {
		almacenamientoDeTerminal.resultadosParcialesPorTerminal()
		}else{throw new NoValidoException("Esta accion está habilitada")}
	}	

	*/

