package dominio

import java.util.List

interface ServicioExterno {
	def List<CentroDTO> buscar(String zona)
		
	
}