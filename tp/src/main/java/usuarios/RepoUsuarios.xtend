package usuarios

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import java.util.HashSet
import java.util.Set
import excepciones.UsuarioException

class RepoUsuarios {
	private static RepoUsuarios instance=new RepoUsuarios()
	private new(){
	}
	var Set<PerfilDeUsuario> usuarios=new HashSet<PerfilDeUsuario>
	def public static RepoUsuarios getInstance(){
		return instance
	}
	def void create(PerfilDeUsuario usu){
		if(usuarios.findFirst[usuario|usuario.nombre==usu.nombre]==null){
		usuarios.add(usu)}
		else{throw new UsuarioException("ya existe el usuario")}
	}
	
	def PerfilDeUsuario search(String usuario){
		var PerfilDeUsuario rdo=usuarios.findFirst[usu|usu.nombre==usuario]
		if(rdo==null){throw new UsuarioException("no existe el usuario")}
	else{ return rdo}
	}
	def void delete(PerfilDeUsuario usuario){
		search(usuario.nombre)
		usuarios.removeIf[usu|usu.nombre==usuario.nombre]
	} 
	def void update(PerfilDeUsuario usuario){
		delete(usuario)
		create(usuario)
	}
}