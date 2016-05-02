package dominio

import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class Transformer {
	CGP unCGP
	
	def void transformarCGP(CentroDTO centro){
	val int a= centro.getNumeroComuna()
 	val Set<String> set = new HashSet<String>(centro.serviciosDTO)
 	
 	 unCGP=	new CGP(centro.serviciosDTO, centro.domicilio, centro.getNumeroComuna.toString)
	}
	
	
	
	
	
}