package dominio.PerfilesDeUsuario

import dominio.Busqueda
import dominio.pois.PuntoDeInteres

import java.util.ArrayList
import java.util.List
import observer.Accion
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Transient
import javax.persistence.OneToMany
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorType
import javax.persistence.DiscriminatorColumn
import javax.persistence.Inheritance
import javax.persistence.Id
import javax.persistence.GeneratedValue
import java.util.Set
import javax.persistence.CollectionTable
import javax.persistence.ElementCollection
import javax.persistence.JoinColumn
import org.hibernate.annotations.GenericGenerator

@Accessors
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoPoi", discriminatorType=DiscriminatorType.INTEGER)
public abstract class PerfilDeUsuario {
	@Transient
	Busqueda buscador
	@Id
	@Column(length=150)
	String nombre
	@Column(length=150)
	String contraseña
	@Transient
	List<Accion> listaDeAcciones = new ArrayList<Accion>
	@ElementCollection
	@CollectionTable(name="favoritos", joinColumns=@JoinColumn(name="nombre"))
	@Column(name="favorito")
	Set<Integer> favoritos = new HashSet<Integer>

	def List<PuntoDeInteres> buscar(String str) {
		buscador.buscar(str, this)
	}

	def boolean estaHabilitadaLaAccion(Accion accion)
}
