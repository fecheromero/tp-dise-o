package interfazAServiciosExternos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class ServicioDTO {
	String nombreServicio
	ArrayList<RangoServicioDTO> rangosServicioDTO

	new(String nombre, ArrayList<RangoServicioDTO> rangos){
		nombreServicio=nombre
		rangosServicioDTO=rangos
	}
}
