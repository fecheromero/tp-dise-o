package decorator

import java.util.HashMap

class InformeTotalUsuario implements InterfazInforme{
	private static InformeTotalUsuario uno=new InformeTotalUsuario()
		private new( ){}
		def public static InformeTotalUsuario getInstance(){
			uno
		}
		override HashMap<String,Integer> informar(Terminal terminal){
		Registros.instance.informeTotalesPorTerminal
	}
}