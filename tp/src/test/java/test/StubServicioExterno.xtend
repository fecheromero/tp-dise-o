package test

import dominio.ServicioExterno
import java.util.ArrayList
import dominio.CentroDTO
import com.google.common.collect.Lists

class StubServicioExterno implements ServicioExterno{
		ArrayList<CentroDTO> listaCentrosDTO
		
		override buscar(String zona){
			Lists.newArrayList(listaCentrosDTO.filter[unCentro|unCentro.domicilio==zona ||unCentro.zonasIncluidas==zona ])
		}
}