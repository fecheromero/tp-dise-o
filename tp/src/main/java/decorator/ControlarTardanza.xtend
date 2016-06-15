package decorator

import dominio.Busqueda

class ControlarTardanza implements InterfazDeBusqueda{
	InterfazDeBusqueda sig
	MailSender mailSender
	long tardanzaMax
	Administrador admin
	
	new(Busqueda busq,MailSender mailS, long tard, Administrador _admin){
		sig=busq
		mailSender=mailS
		tardanzaMax=tard
		admin=_admin
	}
	def override buscar(String str,Terminal term){
		sig.buscar(str,term)
	if(term.tardanza>tardanzaMax){
		mailSender.sendMail(admin)
	}	
}
}
