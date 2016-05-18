package observer

import java.util.ArrayList

class ResultadosParciales extends Accion{
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	new (AlmacenamientoDeBusqueda almacenamiento){
		almacenamientoDeTerminal=almacenamiento
	}
	override buscar(String frase, Long tiempo, int cantidad) {
	}
	def ArrayList<Integer> resultadosParciales(){
		almacenamientoDeTerminal.resultadosParcialesPorTerminal()
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