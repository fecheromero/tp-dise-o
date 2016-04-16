package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet
import org.joda.time.DateTime
import com.google.common.collect.Sets

@Accessors
public abstract class PuntoDeInteresConServicios extends PuntoDeInteres {
	HashSet<Servicio> servicios

	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		this.horario = horarioDeTodosSusServicios(servicios)
	}

	def Horario horarioDeTodosSusServicios(HashSet<Servicio> servicios) {
		return new Horario(juntarDiasDeServicios(servicios), juntarTurnosDeServicios(servicios))
	}

	def HashSet<Integer> juntarDiasDeServicios(HashSet<Servicio> servicios) {
		return Sets.newHashSet(servicios.map[horario.diasHabilesPoi].flatten())
	}

	def HashSet<Turno> juntarTurnosDeServicios(HashSet<Servicio> servicios) {
		return Sets.newHashSet(servicios.map[horario.turnosDisponibles].flatten())
	}

	def boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		return estaDisponibleElServicio(unMomento, nombreDeServicio)
	}

	def boolean estaDisponibleElServicio(DateTime unMomento, String nombreDeServicio) {
		this.horario = buscarServicioDeNombre(nombreDeServicio).horario
		return this.estaDisponible(unMomento)
	}

	def Servicio buscarServicioDeNombre(String nombreDeServicio) {
		return (servicios.findFirst[unServicio|unServicio.nombre == nombreDeServicio])
	}
}
