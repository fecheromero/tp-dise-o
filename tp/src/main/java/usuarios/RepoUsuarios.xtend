package usuarios

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import java.util.HashSet
import java.util.Set

class RepoUsuarios {
	private static RepoUsuarios instance=new RepoUsuarios()
	private new(){
	}
	var Set<PerfilDeUsuario> usuarios=new HashSet<PerfilDeUsuario>
	def void create(PerfilDeUsuario usu){
		if(search(usu.nombre)!=null){
		usuarios.add(usu)}
	}
	def public static RepoUsuarios getInstance(){
		return instance
	}
	def PerfilDeUsuario search(String usuario){
		usuarios.findFirst[usu|usu.nombre==usuario]
	}
	def void delete(PerfilDeUsuario usuario){
		usuarios.removeIf[usu|usu.nombre==usuario.nombre]
	} 
	def void update(PerfilDeUsuario usuario){
		delete(usuario)
		create(usuario)
	}
}