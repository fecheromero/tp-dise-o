package dependencias

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Identificador {
	int nId=1
	private static Identificador uno=new Identificador()
		private new( ){}
		def public static Identificador getInstance(){
			uno
		}
	def void reset(){
		uno.nId=1
	}
	def int nextId(){
		uno.nId++
	}
	}