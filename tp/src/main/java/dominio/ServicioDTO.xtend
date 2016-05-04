package dominio

import java.util.List
<<<<<<< HEAD

class ServicioDTO {
	String nombreServicio
	List<RangoServicioDTO> rangosServicioDTO
=======
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class ServicioDTO {
	String nombreServicio
	ArrayList<RangoServicioDTO> rangosServicioDTO
>>>>>>> development
}