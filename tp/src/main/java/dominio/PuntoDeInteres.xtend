package dominio

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import excepciones.NoValidoException
import dependencias.*

@Accessors
public abstract class PuntoDeInteres {
	Direccion direccion
	String nombre
	Horario horario
	var double DISTANCIA_MAXIMA = 0.5
	val instanciador=new Instanciador()
	val tag=instanciador.instanciaTageador

	public def String listaDeTags() {
		nombre.concat(" ").concat(direccion.listaDeTags())
	}

	def boolean estaCercaDe(Point coordenadasDestino) {
		direccion.coordenadas.distance(coordenadasDestino) < DISTANCIA_MAXIMA
	}
	
		def boolean estaDisponible(DateTime unMomento) {
		return this.horario.esHabilElMomento(unMomento)
	}
	def void validate(){
		
		if(PuntoDeInteres.declaredFields.exists[field| field.accessible = true
														field.get(this)==null
			
		]) throw new NoValidoException("El Poi no es valido")
		else {this.direccion.validate()}
		}
	/*def void elNegocioEstaDisponibleEnUnMomento(DateTime unMomento) {
		if (this.estaDisponible(unMomento))
			System::out.println("Esta Disponible " + this.nombre + " la fecha: "+ unMomento)
		else
			System::out.println("No esta Disponible " + this.nombre + " la fecha: "+ unMomento)
	}
*/
		
}
