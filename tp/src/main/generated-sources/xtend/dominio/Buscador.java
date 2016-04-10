package dominio;

import com.google.common.base.Objects;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pure;

@SuppressWarnings("all")
public class Buscador {
  private Buscador yo = this;
  
  private final List<String> palabrasInutiles = Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList("a", "ante", "cabe", "con", "contra", "de", "desde", "en", "entre", "para", "por", "segun", "sin", "sobre", "tras", "durante", "mediante", "el", "las", "los", "la"));
  
  public boolean esPalabraInutil(final String str1) {
    final Function1<String, Boolean> _function = new Function1<String, Boolean>() {
      public Boolean apply(final String it) {
        return Boolean.valueOf(Objects.equal(it, str1));
      }
    };
    return IterableExtensions.<String>exists(this.palabrasInutiles, _function);
  }
  
  public String masParecido(final String str1, final String str2, final String str3) {
    String _xifexpression = null;
    int _levenshtein = this.levenshtein(str1, str3);
    int _levenshtein_1 = this.levenshtein(str2, str3);
    boolean _greaterThan = (_levenshtein > _levenshtein_1);
    if (_greaterThan) {
      _xifexpression = str2;
    } else {
      _xifexpression = str1;
    }
    return _xifexpression;
  }
  
  public int minimum(final int a, final int b, final int c) {
    if (((a <= b) && (a <= c))) {
      return a;
    }
    if (((b <= a) && (b <= c))) {
      return b;
    }
    return c;
  }
  
  @Pure
  public static int[][] newIntArrayOfSize(final int nrow, final int ncol) {
    Object[] _newArrayOfSize = new Object[nrow];
    final Function1<Object, int[]> _function = new Function1<Object, int[]>() {
      public int[] apply(final Object it) {
        return new int[ncol];
      }
    };
    return ((int[][])Conversions.unwrapArray(ListExtensions.<Object, int[]>map(((List<Object>)Conversions.doWrapArray(_newArrayOfSize)), _function), int[].class));
  }
  
  public int levenshtein(final char[] str1, final char[] str2) {
    int _length = str1.length;
    int _plus = (_length + 1);
    int _length_1 = str2.length;
    int _plus_1 = (_length_1 + 1);
    int[][] distance = Buscador.newIntArrayOfSize(_plus, _plus_1);
    for (int i = 0; (i <= str1.length); i++) {
      int[] _get = distance[i];
      _get[0] = i;
    }
    for (int j = 0; (j <= str2.length); j++) {
      int[] _get = distance[0];
      _get[j] = j;
    }
    for (int i = 1; (i <= str1.length); i++) {
      for (int j = 1; (j <= str2.length); j++) {
        int[] _get = distance[i];
        int[] _get_1 = distance[(i - 1)];
        int _get_2 = _get_1[j];
        int _plus_2 = (_get_2 + 1);
        int[] _get_3 = distance[i];
        int _get_4 = _get_3[(j - 1)];
        int _plus_3 = (_get_4 + 1);
        int[] _get_5 = distance[(i - 1)];
        int _get_6 = _get_5[(j - 1)];
        int _xifexpression = (int) 0;
        char _get_7 = str1[(i - 1)];
        char _get_8 = str2[(j - 1)];
        boolean _equals = (_get_7 == _get_8);
        if (_equals) {
          _xifexpression = 0;
        } else {
          _xifexpression = 1;
        }
        int _plus_4 = (_get_6 + _xifexpression);
        int _minimum = this.minimum(_plus_2, _plus_3, _plus_4);
        _get[j] = _minimum;
      }
    }
    int _length_2 = str1.length;
    int[] _get = distance[_length_2];
    int _length_3 = str2.length;
    return _get[_length_3];
  }
  
  public int levenshtein(final String str1, final String str2) {
    char[] _charArray = str1.toCharArray();
    char[] _charArray_1 = str2.toCharArray();
    return this.levenshtein(_charArray, _charArray_1);
  }
  
  public String[] separarPalabras(final String s) {
    int ind = 0;
    char[] palabra = null;
    int intP = 0;
    String[] partes = null;
    for (int i = 0; (i <= s.length()); i++) {
      char _charAt = s.charAt(i);
      boolean _equals = Objects.equal(Character.valueOf(_charAt), " ");
      if (_equals) {
        final char[] _converted_palabra = (char[])palabra;
        String _string = ((List<Character>)Conversions.doWrapArray(_converted_palabra)).toString();
        partes[ind] = _string;
        final char[] _converted_palabra_1 = (char[])palabra;
        ((List<Character>)Conversions.doWrapArray(_converted_palabra_1)).clear();
        ind++;
        intP = 0;
      } else {
        char _charAt_1 = s.charAt(i);
        palabra[intP] = _charAt_1;
        intP++;
      }
    }
    return partes;
  }
  
  /**
   * {
   * var String[] lista=#[]
   * var char[] palabra=#[]
   * var int indice
   * 
   * for(var int i;i<=s.length;i++){
   * if(s.charAt(i)!=' '){palabra.set(indice,s.charAt(i)) indice++}
   * else {indice=0
   * lista.add(palabra.toString)
   * palabra=#[]}
   * }
   * if(indice!=0) lista.add(palabra.toString)
   * return lista
   * }
   */
  public boolean sonParecidas(final String str1, final String str2) {
    boolean _xblockexpression = false;
    {
      int limitador = 0;
      int _length = str1.length();
      int _length_1 = str2.length();
      boolean _lessThan = (_length < _length_1);
      if (_lessThan) {
        int _length_2 = str2.length();
        limitador = _length_2;
      } else {
        int _length_3 = str1.length();
        limitador = _length_3;
      }
      int _levenshtein = this.levenshtein(str1, str2);
      _xblockexpression = (_levenshtein < limitador);
    }
    return _xblockexpression;
  }
  
  public Collection<Integer> ordenador(final Collection<Integer> numeros) {
    final Comparator<Integer> _function = new Comparator<Integer>() {
      public int compare(final Integer num1, final Integer num2) {
        int _xifexpression = (int) 0;
        boolean _greaterThan = (num1.compareTo(num2) > 0);
        if (_greaterThan) {
          _xifexpression = 1;
        } else {
          _xifexpression = (-1);
        }
        return _xifexpression;
      }
    };
    return IterableExtensions.<Integer>sortWith(numeros, _function);
  }
  
  public String seleccionarLaMasParecida(final String str, final String[] palabras) {
    final Function1<String, Boolean> _function = new Function1<String, Boolean>() {
      public Boolean apply(final String it) {
        return Boolean.valueOf(Buscador.this.sonParecidas(it, str));
      }
    };
    Iterable<String> _filter = IterableExtensions.<String>filter(((Iterable<String>)Conversions.doWrapArray(palabras)), _function);
    final Function2<String, String, String> _function_1 = new Function2<String, String, String>() {
      public String apply(final String palabra1, final String palabra2) {
        return Buscador.this.masParecido(palabra1, palabra2, str);
      }
    };
    return IterableExtensions.<String, String>fold(_filter, " ", _function_1);
  }
  
  public int puntajeTotalDelPunto(final /* Poi */Object unPunto, final String str1) {
    throw new Error("Unresolved compilation problems:"
      + "\nlistaDeTags cannot be resolved");
  }
  
  public /* Poi */Object puntoMasSemejanteA(final String str1, final /* Poi */Object punto1, final /* Poi */Object punto2) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method puntajeTotalDelPunto(Poi, String) from the type Buscador refers to the missing type Poi"
      + "\nThe method puntajeTotalDelPunto(Poi, String) from the type Buscador refers to the missing type Poi");
  }
  
  public /* Collection<Poi> */Object OrdenarPuntosSegunSemejansaA(final String str1, final /* Collection<Poi> */Object puntos) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method puntajeTotalDelPunto(Poi, String) from the type Buscador refers to the missing type Poi"
      + "\nThe method puntajeTotalDelPunto(Poi, String) from the type Buscador refers to the missing type Poi"
      + "\nlistaDeTags cannot be resolved"
      + "\nexists cannot be resolved");
  }
}
