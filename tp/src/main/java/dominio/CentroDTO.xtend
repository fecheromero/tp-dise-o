package dominio

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
public class CentroDTO {
	Integer numeroComuna
	String zonasIncluidas
	String nombreDirector
	String domicilio
	String telefono
	ArrayList<ServicioDTO> serviciosDTO
	Point coordenadas
	new(String director,Integer comuna, String direccion,String zonas,String tel,Point punto,ArrayList<ServicioDTO> servicios){
		nombreDirector=director
		numeroComuna=comuna
		zonasIncluidas=zonas
		telefono=tel
		coordenadas=punto
		serviciosDTO=servicios
		domicilio=direccion
	}
}
