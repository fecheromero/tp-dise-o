package interfazAServiciosExternos


import java.util.ArrayList
import stubs.CentroDTO

public interface InterfazCGP {
	def ArrayList<CentroDTO> buscar(String zona)			
}
