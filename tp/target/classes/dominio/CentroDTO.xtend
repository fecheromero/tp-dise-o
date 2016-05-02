package dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet
import java.util.ArrayList

@Accessors
public class CentroDTO {
	Integer numeroComuna
	String zonasIncluidas
	String nombreDirector
	String domicilio
	String telefono
	ArrayList<ServicioDTO> serviciosDTO
}
