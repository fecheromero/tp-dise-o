package dominio

import java.util.List
import java.util.ArrayList

interface ServicioExterno {
	def ArrayList<CentroDTO> buscar(String zona)
		
	
}