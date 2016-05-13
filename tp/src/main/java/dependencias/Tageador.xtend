package dependencias

class Tageador {
	private static Tageador uno=new Tageador()
		private new( ){}
		def public static Tageador getInstance(){
			uno
		}
	
	def String tagear(Object obj){
		var String lista=""
		var listaDeCampos=obj.class.declaredFields
		listaDeCampos.forEach[field|field.accessible=true]
		lista.concat(listaDeCampos.filter[field|field.getType()==String].map[field|field.get(obj).toString].fold("",[palabra1, palabra2 | palabra1.concat(" ").concat(palabra2)]))
		}
		//hecho el refactor del constructor sobre PuntoDeInteres se puede usar el tagear directamente sobre punto de interes
		}