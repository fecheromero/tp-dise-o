package views

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ParParametrico {
	String parametro
	String descripcion
	new(String p,String d){
		parametro=p
		descripcion=d
	}
	}