package dominio

import java.util.Collection
import java.util.Comparator

public class Buscador {
	var yo=this
	val palabrasInutiles=#["a","ante","cabe","con","contra","de","desde","en","entre","para","por","segun","sin","sobre","tras","durante","mediante","el","las","los","la"]
	def boolean esPalabraInutil(String str1)
	{palabrasInutiles.exists[it==str1]}
	def String masParecido(String str1, String str2, String str3) {
		if(this.levenshtein(str1, str3) > this.levenshtein(str2, str3)) str2 else str1
	}

	def int minimum(int a, int b, int c) {
		if (a <= b && a <= c) {
			return a;
		}
		if (b <= a && b <= c) {
			return b;
		}
		return c;
	}

	@Pure
	static def int[][] newIntArrayOfSize(int nrow, int ncol) {
		newArrayOfSize(nrow).map[newIntArrayOfSize(ncol)]
	}

	def int levenshtein(char[] str1, char[] str2) {

		var int[][] distance = newIntArrayOfSize(str1.length + 1, str2.length + 1)

		for (var int i = 0; i <= str1.length; i++) {
			distance.get(i).set(0, i)
		}
		for (var int j = 0; j <= str2.length; j++) {
			distance.get(0).set(j, j)
		}
		for (var int i = 1; i <= str1.length; i++) {
			for (var int j = 1; j <= str2.length; j++) {
				distance.get(i).set(j, minimum((distance.get(i - 1).get(j) + 1), (distance.get(i).get(j - 1) + 1),
					distance.get(i - 1).get(j - 1) + (if(str1.get(i - 1) == str2.get(j - 1)) 0 else 1)))

			}
		}
		return distance.get(str1.length).get(str2.length)

	}

	def int levenshtein(String str1, String str2) {
		return levenshtein(str1.toCharArray(), str2.toCharArray());
	}

	def String[] separarPalabras(String s){
        var int ind = 0
        var char[] palabra
        var intP=0
        var String[] partes
        for (var int i = 0; i <= s.length(); i++) {
            if (s.charAt(i) == ' ') {
              partes.set(ind,palabra.toString()) 
              palabra.clear
              ind++ 
              intP=0
            }
            else {palabra.set(intP,s.charAt(i))
            	intP++        	
            }
        }
        return partes // Devolvemos las partes
    } /*{
		 var String[] lista=#[]
		 var char[] palabra=#[]
		 var int indice
		
		 for(var int i;i<=s.length;i++){
		 	if(s.charAt(i)!=' '){palabra.set(indice,s.charAt(i)) indice++}
		 	else {indice=0
		 	lista.add(palabra.toString)
		 	palabra=#[]}
		 }    
		 if(indice!=0) lista.add(palabra.toString)
		 return lista
		 }	*/
 

	def boolean sonParecidas(String str1, String str2) {
		var int limitador
		if(str1.length < str2.length) limitador = str2.length else limitador = str1.length
		levenshtein(str1, str2) < limitador
	 }
	 
	 
	 def Collection<Integer> ordenador(Collection<Integer> numeros)
	 {     
	   numeros.sort[num1,num2|if(num1>num2) 1 else -1]
	  }
	def String seleccionarLaMasParecida(String str, String[] palabras) {
		palabras.filter[this.sonParecidas(it, str)].fold(" ", [palabra1, palabra2|masParecido(palabra1, palabra2, str)])
	}
	def int puntajeTotalDelPunto(Poi unPunto,String str1)
	{
		this.separarPalabras(str1).map[this.levenshtein(this.seleccionarLaMasParecida(it, unPunto.listaDeTags()),it)].fold(0,[num1, num2| (num1+num2)])
	}
	def Poi puntoMasSemejanteA(String str1, Poi punto1,Poi punto2)
	{if(this.puntajeTotalDelPunto(punto1, str1)<this.puntajeTotalDelPunto(punto2,str1)) punto1 else punto2}	
	def Collection<Poi> OrdenarPuntosSegunSemejansaA(String str1, Collection<Poi> puntos){
		puntos.filter[it.listaDeTags().exists[this.sonParecidas(str1,it)]].sort[p1,p2|if(yo.puntajeTotalDelPunto(p1,str1)<yo.puntajeTotalDelPunto(p2,str1)) 1 else -1]
	}	
	}
	
	/*public class CreadorDeComparadoresDePuntos{
		def Comparator<Poi> crearComparador(String str1, Buscador buscador){
			new Comparator<Poi>(){
				public override int compare(Poi p1,Poi p2){
					if(buscador.puntajeTotalDelPunto(p1,str1)<buscador.puntajeTotalDelPunto(p2,str1)) 1 else -1}
			}
		}*/
	


