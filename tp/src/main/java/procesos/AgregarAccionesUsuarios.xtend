package procesos

import java.util.List
import dominio.PerfilesDeUsuario.Consulta
import java.util.ArrayList
import observer.Accion

class AgregarAccionesUsuarios implements Proceso{
	List<Consulta> listaDeUsuarios= new ArrayList
//	List<PerfilDeUsuario> listaDeUsuariosUndo= new ArrayList
	List<Accion> listaDeAcciones=new ArrayList
	
	new (List<Consulta> usuarios,List<Accion> acciones){
		listaDeUsuarios=usuarios
		listaDeAcciones=acciones
		
	}
	
	override exec() {
		listaDeUsuarios.forEach[usuario|agregarAccionesAUsuario(usuario)]
	}
	def void agregarAccionesAUsuario(Consulta usuario){
		listaDeAcciones.forEach[accion|usuario.habilitarAccion(accion)]
	}
	def void eliminarAccionesAUsuario(Consulta usuario){
		listaDeAcciones.forEach[accion|usuario.deshabilitarAccion(accion)]
	}
	def void undo(){
		listaDeUsuarios.forEach[usuario|eliminarAccionesAUsuario(usuario)]
	}
}
