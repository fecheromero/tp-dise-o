package decorator

import java.text.SimpleDateFormat
import java.util.Date
import dominio.Busqueda

class RegistrarBusqueda implements InterfazDeBusqueda {
	Registros registros=Registros.getInstance
	String fecha
	InterfazDeBusqueda sig
	new(ControlarTardanza cont){
		sig=cont
	}
	def  override buscar(String str,Terminal term){
		sig.buscar(str,term)
		fecha=new SimpleDateFormat("dd/MM/yyyy").format(new Date())
		registros.create(new RegistroDeBusqueda(fecha,str,term.rdo.size,term,term.tardanza))	
		}
	}