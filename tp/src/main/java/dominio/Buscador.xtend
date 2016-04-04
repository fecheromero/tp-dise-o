package dominio

public class Buscador {
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

	def String[] separarPalabras(String str1) {
		var char[] cadena = str1.toCharArray()
		var int longitud = cadena.length
		var String[] listaDePalabras

		var char[] palabra
		var int puntero
		for (var int i = 0; i <= longitud; i++) {
			if (cadena.get(i) == ' ') {
				listaDePalabras.add(palabra.toString())
				puntero = 0
				i++
			} else {
				palabra.set(puntero, cadena.get(i))
				i++
				puntero++
			}
		}
		if(puntero != 0) listaDePalabras.add(palabra.toString())
		return listaDePalabras
	}

	def boolean sonParecidas(String str1, String str2) {
		var int limitador
		if(str1.length < str2.length) limitador = str1.length else limitador = str2.length
		levenshtein(str1, str2) < limitador
	}

	def String seleccionarLaMasParecida(String str, String[] palabras) {
		palabras.filter[this.sonParecidas(it, str)].fold(" ", [palabra1, palabra2|masParecido(palabra1, palabra2, str)])

	}
}
