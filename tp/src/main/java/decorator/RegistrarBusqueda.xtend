package decorator

import java.text.SimpleDateFormat
import java.util.Date
import dominio.Busqueda

class RegistrarBusqueda implements InterfazDeBusqueda {
	Registros registros=Registros.getInstance
	String fecha=new SimpleDateFormat("dd/mm/yyyy").format(new Date())
	InterfazDeBusqueda sig
	new(){
		sig=new Busqueda()
	}
	def override sig(){
			sig
		}
		def override sig(InterfazDeBusqueda _sig){
		sig=_sig
	}
	def  override buscar(String str,Terminal terminal){
		sig.buscar(str,terminal)
		registros.create(new RegistroDeBusqueda(fecha,str,terminal.rdo.size,terminal,terminal.tardanza))	
		}
	}