package dominio

import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class Transformer {
	CGP unCGP

	def void transformarCGP(CentroDTO centro) {
		val int a = centro.numeroComuna
		val Set<ServicioDTO> set = new HashSet<ServicioDTO> (centro.serviciosDTO)

	//	unCGP = new CGP(new HashSet <Servicio> (centro.serviciosDTO), (centro.serviciosDTO)centro.domicilio, centro.getNumeroComuna.toString)
	}

}
