package test

import dominio.ServicioExterno
import java.util.ArrayList
import dominio.CentroDTO
import com.google.common.collect.Lists

class StubServicioExterno implements ServicioExterno {
	ArrayList<CentroDTO> listaCentros
	
	override buscar(String zona) {
		Lists.newArrayList(listaCentros.filter[unCentro|unCentro.domicilio==zona])
	}
	
	def void agregarCentroDTO(CentroDTO centro){
		listaCentros.add(centro)
	}
}