package dominio

import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import dominio.pois.PuntoDeInteres
import fixtures.ParadaColectivoFixture
import dominio.pois.ParadaDeColectivo
import dominio.pois.CGP
import dominio.pois.SucursalBanco
import dominio.pois.Direccion
import dominio.pois.Review
import dominio.pois.Servicio
import dominio.tiempo.Horario
import dominio.pois.Comuna
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import excepciones.UsuarioException
import dominio.locales.LocalComercial
import dominio.locales.Rubro
import dominio.PerfilesDeUsuario.PerfilDeUsuario
import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.Consulta
import dominio.tiempo.Dia
import dominio.tiempo.Momento
import dominio.tiempo.Turno

abstract class RepoDefault<T> {
	
	protected static final SessionFactory sessionFactory = new Configuration().configure()
		.addAnnotatedClass(Review)
		.addAnnotatedClass(PuntoDeInteres)
		.addAnnotatedClass(ParadaDeColectivo)
		.addAnnotatedClass(CGP)
		.addAnnotatedClass(SucursalBanco)
		.addAnnotatedClass(Direccion)
		.addAnnotatedClass(Servicio)
		.addAnnotatedClass(Horario)
		.addAnnotatedClass(Comuna)
		.addAnnotatedClass(Polygon)
		.addAnnotatedClass(Point)
		.addAnnotatedClass(LocalComercial)
		.addAnnotatedClass(Rubro)
		.addAnnotatedClass(PerfilDeUsuario)
		.addAnnotatedClass(Administrador)
		.addAnnotatedClass(Consulta)
		.addAnnotatedClass(PuntoDeInteres)
		.addAnnotatedClass(Dia)
		.addAnnotatedClass(Horario)
		.addAnnotatedClass(Momento)
		.addAnnotatedClass(Turno)	
		.buildSessionFactory()

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.flush()
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def openSession() {
		sessionFactory.openSession
	}
	
}