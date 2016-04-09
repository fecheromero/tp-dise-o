package dominio

import org.uqbar.geodds.Point
import java.util.List

public abstract class PuntoDeInteres {
	
	Direccion direccion
	String nombre
	static double FACTOR_CONVERSION = 0.001
	static double DISTANCIA_MAXIMA = 500
	
	def boolean estaCercaDe(Point coordenadasDestino) {
		this.verificarCercania(this, coordenadasDestino, DISTANCIA_MAXIMA)
	}
	
	def boolean verificarCercania (PuntoDeInteres unPunto, Point coordenadasDestino, double distanciaMaxima){
		var double distancia
		
		distancia = this.getDireccion.getCoordenadas.distance(coordenadasDestino)
		if (distancia*FACTOR_CONVERSION < DISTANCIA_MAXIMA){
			return true
		}else{
			return false
		}
	}
	
	
	def Direccion getDireccion(){
		return direccion
	}
	

}