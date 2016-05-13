package decorator

import dominio.Busqueda

class ControlarTardanza implements InterfazDeBusqueda {
	int tardanzaMax
	Administrador admin
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
	def override buscar(String str,Terminal terminal){
	if(terminal.tardanza>tardanzaMax){
		sendMail(admin)
	}	
	}
	def void sendMail(Administrador admin){
		
	}
	}