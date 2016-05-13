package stubs

import interfazAServiciosExternos.InterfazCGP
import java.util.ArrayList
import com.google.common.collect.Lists

public class StubServicioExternoCGP implements InterfazCGP {
	ArrayList<CentroDTO> listaCentros = new ArrayList<CentroDTO>
	
	override ArrayList<CentroDTO> buscar(String zona) {
		return listaCentros
	}
	
	def void agregarCentroDTO(CentroDTO centro){
		listaCentros.add(centro)
	}
} 