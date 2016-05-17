package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import java.util.ArrayList
import excepciones.NoValidoException

class ResultadosParciales extends Accion{
	AlmacenamientoDeBusqueda almacenamientoDeTerminal
	new (AlmacenamientoDeBusqueda almacenamiento){
		almacenamientoDeTerminal=almacenamiento
	}
	override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario usuario) {
	}
	def ArrayList<Integer> resultadosParciales(){
		if (dueño.estaHabilitadaLaAccion(this)) {
		almacenamientoDeTerminal.resultadosParcialesPorTerminal()
		}else{throw new NoValidoException("Esta accion está habilitada")}
	}	
}