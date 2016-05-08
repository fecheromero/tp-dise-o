package stubs

import java.util.ArrayList
import interfazAServiciosExternos.ServicioExterno
import stubs.CentroDTO
import com.google.common.collect.Lists

class StubServicioExterno extends ServicioExterno {
	ArrayList<CentroDTO> listaCentros
	
	override buscar(String zona) {
		Lists.newArrayList(listaCentros.filter[unCentro|unCentro.domicilio==zona])
	}
	
	def void agregarCentroDTO(CentroDTO centro){
		listaCentros.add(centro)
	}
} 