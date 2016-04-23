package dependencias
import dependencias.Levenshtein
import dependencias.Tageador
class Instanciador {
	 var tageador=new Tageador()
	 var levenshtein=new Levenshtein()

	 def  Levenshtein instanciaLevenshtein() {
	 	levenshtein
	}
	def Tageador instanciaTageador(){
		tageador
	}
	}