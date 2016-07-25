package combo_de_productos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Producto {
	var Double precio
	var  String descripcion
	
	new(Double _p,String _d){
		precio=_p
		descripcion=_d
}
}