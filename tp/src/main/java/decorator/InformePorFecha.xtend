package decorator

import java.util.HashMap

class InformePorFecha implements InterfazInforme {
	private static InformePorFecha uno=new InformePorFecha()
		private new( ){}
		def public static InformePorFecha getInstance(){
			uno
		}
	
		override HashMap<String,Integer> informar(Terminal terminal){
		Registros.instance.informeCantDeBusquedasXFecha
	}
}