package decorator

import org.uqbar.geodds.Point
import java.util.List
import dominio.pois.PuntoDeInteres
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Terminal implements PerfilDeUsuario {
	String nombre
	Point ubicacion
	InterfazDeBusqueda decorador
	List<PuntoDeInteres> rdo
	long tardanza
	new(String n,Point p,InterfazDeBusqueda d){
		nombre=n
		ubicacion=p
		decorador=d
	}
	def void buscar(String str){
		decorador.buscar(str,this)
	}
}