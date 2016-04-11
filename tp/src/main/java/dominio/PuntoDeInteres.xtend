package dominio

import org.uqbar.geodds.Point
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.lang.reflect.Array
import java.util.ArrayList
import java.util.HashSet

@Accessors
public abstract class PuntoDeInteres {

	Direccion direccion
	String nombre
	Horario horario
	//static double FACTOR_CONVERSION = 0.001
	 var double DISTANCIA_MAXIMA = 0.5

	public def String listaDeTags() {
		var String lista = ""
		lista.concat(#[this.nombre, this.direccion.listaDeTags()].fold("", [ palabra1, palabra2 |
			palabra1.concat(" ").concat(palabra2)
		]))
	}

	def boolean estaCercaDe(Point coordenadasDestino) {
		direccion.coordenadas.distance(coordenadasDestino)<DISTANCIA_MAXIMA
	}

	//def boolean verificarCercania(PuntoDeInteres unPunto, Point coordenadasDestino, double distanciaMaxima) {
	//	var double distancia

	//	distancia = this.getDireccion.getCoordenadas.distance(coordenadasDestino)
	//	if (distancia * FACTOR_CONVERSION < DISTANCIA_MAXIMA) {
	//		return true
	//	} else {
	//		return false
	//	}
	//}

	//def Direccion getDireccion() {                      //el Accesor ya existe es .direccion//
	//	return direccion
	//}

	def boolean estaDisponible(Momento unMomento) 

	def boolean estaDisponible(Momento unMomento, String nombreDeServicio) 
	
	def void setearDiasHabiles(List<String> diasHabiles)	{
		this.horario.setearDiasHabiles(diasHabiles)
	} 
	
	
}
