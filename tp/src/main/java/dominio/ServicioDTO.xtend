package dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class ServicioDTO {
	String nombreServicio
	ArrayList<RangoServicioDTO> rangosServicioDTO

}