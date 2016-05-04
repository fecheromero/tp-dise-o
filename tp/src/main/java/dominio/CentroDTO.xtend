package dominio

import java.awt.Point
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class CentroDTO {
	Integer numeroComuna
	String zonasIncluidas
	String nombreDirector
	String domicilio
	String telefono
	ArrayList<ServicioDTO> serviciosDTO
	Point coordenadas
}
