package dominio

import java.util.Collection
import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import dependencias.Instanciador
import dependencias.Levenshtein
@Accessors
public class Buscador {
	val yo=this
	val instanciador=new Instanciador()
	var Levenshtein lev= instanciador.instanciaLevenshtein()
	static val palabrasInutiles=#["a","ante","cabe","con","contra","de","desde","en","entre","para","por","segun","sin","sobre","tras","durante","mediante","el","las","los","la"]
	HashSet<PuntoDeInteres> puntos
	def boolean esPalabraInutil(String str1)
	{palabrasInutiles.exists[it==str1]}
	def String masParecido(String str1, String str2, String str3) {
		if(lev.levenshtein(str1, str3) > lev.levenshtein(str2, str3)) str2 else str1
	}

	
	def String[] separarPalabras(String s){
		 s.split(" ")
	}

	def boolean sonParecidas(String str1, String str2) {
		var int limitador
		if(str1.length < str2.length) limitador = str2.length else limitador = str1.length
		lev.levenshtein(str1, str2) < limitador
	 }
	 
	 

	def String seleccionarLaMasParecida(String str, String[] palabras) {
		palabras.filter[this.sonParecidas(it, str)].fold(" ", [palabra1, palabra2|masParecido(palabra1, palabra2, str)])
	}
	def int puntajeTotalDelPunto(PuntoDeInteres unPunto,String str1)
	{
		this.separarPalabras(str1).map[lev.levenshtein(this.seleccionarLaMasParecida(it, this.separarPalabras(unPunto.listaDeTags())),it)].fold(0,[num1, num2| (num1+num2)])
	}
	def PuntoDeInteres puntoMasSemejanteA(String str1, PuntoDeInteres punto1,PuntoDeInteres punto2)
	{if(this.puntajeTotalDelPunto(punto1, str1)<this.puntajeTotalDelPunto(punto2,str1)) punto1 else punto2}	
	
	def Collection<PuntoDeInteres> ordenarPuntosSegunSemejanzaA(String str1){
		puntos.filter[this.separarPalabras(it.listaDeTags()).exists[this.sonParecidas(str1,it)]].sort[p1,p2|if(yo.puntajeTotalDelPunto(p1,str1)>yo.puntajeTotalDelPunto(p2,str1)) 1 else -1]
	}
	def PuntoDeInteres[] topTenDePuntos(String str1){
		this.ordenarPuntosSegunSemejanzaA(str1).take(10)
	}
	}
	

	


