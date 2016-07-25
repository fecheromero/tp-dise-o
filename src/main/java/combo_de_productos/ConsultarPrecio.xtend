package combo_de_productos

import java.util.List
import java.util.HashSet
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class ConsultarPrecio {
	var Set<Producto> listaDeProductos=new HashSet<Producto>
	var Producto producto
	var Boolean enable=false
	var Boolean visible=false
}