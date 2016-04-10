package dominio

import org.uqbar.geodds.Point
import java.util.List

public class CGP extends PuntoDeInteres{
	String tipo
	List<Servicio> servicios
	
	override boolean estaCercaDe(Point coordenadasDestino){
		this.getDireccion.getComuna.getPoligono.isInside(coordenadasDestino)
	}
	
}