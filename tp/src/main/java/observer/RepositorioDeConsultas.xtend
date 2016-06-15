package observer

import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

public class RepositorioDeConsultas {
	@Accessors	
	List<RegistroPorBusqueda> listaDeBusquedas = new ArrayList<RegistroPorBusqueda>
	private static RepositorioDeConsultas uno=new RepositorioDeConsultas()
		private new( ){}
		def public static RepositorioDeConsultas getInstance(){
			uno
		}
		def void reset(){
		listaDeBusquedas.clear
	}
	
	
	
	
	
}