package dependencias

class Levenshtein {
		private static Levenshtein uno=new Levenshtein()
		private new( ){}
		def public static Levenshtein getInstance(){
			uno
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
	
}