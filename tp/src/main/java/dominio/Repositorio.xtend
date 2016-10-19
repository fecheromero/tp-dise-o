package dominio

import dependencias.Buscador
import dominio.pois.PuntoDeInteres
import excepciones.NoValidoException
import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import interfazAServiciosExternos.InterfazCGP
import java.util.ArrayList
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import java.util.Set

@Accessors
class Repositorio extends RepoDefault<PuntoDeInteres> implements OrigenDePois  {
	InterfazCGP servicioExtCGP
	Set<PuntoDeInteres> puntos=new HashSet<PuntoDeInteres>
	Buscador buscador=Buscador.getInstance
	private static Repositorio uno=new Repositorio()
		private new( ){}
		def public static Repositorio getInstance(){
			uno
		}
	def void reset(){
		uno=new Repositorio()
	}
	

	def void setServicioDTO(InterfazCGP servicio){
		servicioExtCGP=servicio
	}
	override create(PuntoDeInteres unPunto){
		unPunto.validate()
		if(searchBynd(unPunto.id)!=null) throw new NoValidoException("El Punto ya existe")
		else{
				val session = sessionFactory.openSession
				try {
			session.beginTransaction
			session.save(unPunto.direccion.comuna)
			session.save(unPunto.direccion)
			if(unPunto.servicios.isNullOrEmpty){}
			else{unPunto.servicios.forEach[servicio| session.save(servicio)]}
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
			super.create(unPunto) 
			println("cree A:");
			println(unPunto.nombre);
		}
	}
	override update(PuntoDeInteres unPunto){
		unPunto.validate
		super.update(unPunto)
		}
	def void delete(PuntoDeInteres unPunto){
		if(searchBynd(unPunto.id)!=null)puntos.remove(searchBynd(unPunto.id))
		else{throw new NoValidoException("El Punto no existe")}
	}
	
		
	def PuntoDeInteres searchBynd(int id){
		puntos= allInstances.toSet
		puntos.forEach[punto|System.out.println(punto.nombre)]
		puntos.findFirst[punto| punto.id==id]

	}
	def override List<PuntoDeInteres> buscar(String valor){
		puntos= allInstances.toSet
		buscador.mostrarPrimeros(valor,puntos,10)
	}
	
		override getEntityType() {
		typeof(PuntoDeInteres)
	}	

override  addQueryByExample(Criteria criteria, PuntoDeInteres poi) {
	if (poi.nombre != null) {
			criteria.add(Restrictions.eq("nombre", poi.nombre))
		}
}
def PuntoDeInteres get(int id) {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(typeof(PuntoDeInteres))
				.setFetchMode("Reviews", FetchMode.JOIN)
				.add(Restrictions.idEq(id))
				.uniqueResult() as PuntoDeInteres
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

}
