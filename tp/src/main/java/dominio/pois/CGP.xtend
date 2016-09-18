package dominio.pois

import org.uqbar.geodds.Point

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet
import dominio.pois.Servicio
import org.joda.time.DateTime
import excepciones.NoValidoException
import dominio.pois.PuntoDeInteres
import dominio.pois.Direccion
import dependencias.Validable
import dependencias.Identificador
import views.ParParametrico
import views.MasInfoWindow
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
public class CGP extends PuntoDeInteres {
	@Validable
	HashSet<Servicio> servicios
	new(HashSet<Servicio> servicios, Direccion _direccion, String _nombre) {
		this.nombre = _nombre
		this.direccion = _direccion
		this.servicios = servicios
		this.horario = horarioDeTodosSusServicios(servicios)
		this.id=Identificador.getInstance.nextId
	}
	

	override String listaDeTags() {

		super.listaDeTags().concat(" ".concat(servicios.map[servicio|servicio.nombre].fold("", [ serv1, serv2 |
			serv1.concat(serv2)
		])))
	}

	override boolean estaCercaDe(Point coordenadasDestino) {
		this.direccion.comuna.poligono.isInside(coordenadasDestino)
	}

	override boolean estaDisponible(DateTime unMomento, String nombreDeServicio) {
		if (nombreDeServicio == "")
			super.estaDisponible(unMomento, nombreDeServicio)
		else {
			if (this.servicios.exists[servicio|servicio.nombre == nombreDeServicio])
				this.servicios.findFirst [ servicio |
					servicio.nombre == nombreDeServicio
				].estaDisponible(unMomento)
			else {
				throw new NoValidoException("No se encuentra el servicio")
			}

		}
	}
	
override parametrosTextBox(){
	#[new ParParametrico("direccion","direccion.direccionS"),new ParParametrico("zona","direccion.comuna.nombre")]

}
 override parametrosCombos(){
 	#[new ParParametrico("servicios","servicios")]
}
@JsonProperty("tipo")
	
	def String tipo() {
		"CGP"
	
		}
}
