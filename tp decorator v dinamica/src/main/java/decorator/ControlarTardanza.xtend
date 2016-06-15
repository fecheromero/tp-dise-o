package decorator

import dominio.Busqueda

class ControlarTardanza implements InterfazDeBusqueda {
	int tardanzaMax
	Administrador admin
	InterfazDeBusqueda sig
	new(int tard,Administrador _admin){
		sig=new Busqueda()
		tardanzaMax=tard
		admin=_admin
	}
	def override sig(){
			sig
		}
	def override sig(InterfazDeBusqueda _sig){
		sig=_sig
	}
	def override buscar(String str,BusquedaExecuter exec){
		sig.buscar(str,exec)
	if(exec.tardanza>tardanzaMax){
		sendMail(admin)
	}	
	}
	def void sendMail(Administrador admin){
	}
	}