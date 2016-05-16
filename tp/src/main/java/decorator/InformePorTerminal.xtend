package decorator

import java.util.List

class InformePorTerminal implements InterfazInforme {
	private static InformePorTerminal uno=new InformePorTerminal()
		private new( ){}
		def public static InformePorTerminal getInstance(){
			uno
		}
	override List<Integer> informar(Terminal terminal){
		Registros.instance.parcialesPorTerminal(terminal)
	}
}