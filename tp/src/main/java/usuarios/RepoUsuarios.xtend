package usuarios

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import java.util.HashSet
import java.util.Set
import excepciones.UsuarioException
import dominio.RepoDefault
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import excepciones.NoValidoException

@Accessors
class RepoUsuarios extends RepoDefault<PerfilDeUsuario>{
	private static RepoUsuarios instance=new RepoUsuarios()
	private new(){
	}
	var Set<PerfilDeUsuario> usuarios=new HashSet<PerfilDeUsuario>
	def public static RepoUsuarios getInstance(){
		return instance
	}
	//def void create(PerfilDeUsuario usu){
	//	if(usuarios.findFirst[usuario|usuario.nombre==usu.nombre]==null){
	//	usuarios.add(usu)}
	//	else{throw new UsuarioException("ya existe el usuario")}
	//}
	override create(PerfilDeUsuario usu){
		if(usuarios.findFirst[usuario|usuario.nombre==usu.nombre]!=null) throw new NoValidoException("El usuario ya existe")
		else{
				val session = sessionFactory.openSession
				try {
			session.beginTransaction
			if(usu.favoritos.isNullOrEmpty){}
			else{usu.favoritos.forEach[fav| session.save(fav)]}
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
			super.create(usu) 
			println("cree A:");
			println(usu.nombre);
		}
	}
	def PerfilDeUsuario search(String usuario){
		try{
		var PerfilDeUsuario rdo=get(usuario)
		return rdo
		}catch(Exception e){throw new UsuarioException("no existe el usuario")}
	
	}
	def void delete(PerfilDeUsuario usuario){
		search(usuario.nombre)
		usuarios.removeIf[usu|usu.nombre==usuario.nombre]
	} 
//	def void update(PerfilDeUsuario usuario){
//		delete(usuario)
//		create(usuario)
//	}
	
	override getEntityType() {
		typeof(PerfilDeUsuario)	
	}
	
	override addQueryByExample(Criteria criteria, PerfilDeUsuario user) {
		if (user.nombre != null) {
			criteria.add(Restrictions.eq("nombre", user.nombre))
		}
	}
	def PerfilDeUsuario get(String usu) {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(typeof(PerfilDeUsuario))
				.setFetchMode("favoritos", FetchMode.JOIN)
				.add(Restrictions.idEq(usu))
				.uniqueResult() as PerfilDeUsuario
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
}