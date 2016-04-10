package dominio;

import com.google.common.base.Objects;
import dominio.PuntoDeInteres;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Buscador {
  private final Buscador yo = this;
  
  private final static List<String> palabrasInutiles = Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList("a", "ante", "cabe", "con", "contra", "de", "desde", "en", "entre", "para", "por", "segun", "sin", "sobre", "tras", "durante", "mediante", "el", "las", "los", "la"));
  
  private HashSet<PuntoDeInteres> puntos;
  
  public boolean esPalabraInutil(final String str1) {
    final Function1<String, Boolean> _function = new Function1<String, Boolean>() {
      public Boolean apply(final String it) {
        return Boolean.valueOf(Objects.equal(it, str1));
      }
    };
    return IterableExtensions.<String>exists(Buscador.palabrasInutiles, _function);
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
    return s.split(" ");
  }
  
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
  
  public int puntajeTotalDelPunto(final PuntoDeInteres unPunto, final String str1) {
    String[] _separarPalabras = this.separarPalabras(str1);
    final Function1<String, Integer> _function = new Function1<String, Integer>() {
      public Integer apply(final String it) {
        String _listaDeTags = unPunto.listaDeTags();
        String[] _separarPalabras = Buscador.this.separarPalabras(_listaDeTags);
        String _seleccionarLaMasParecida = Buscador.this.seleccionarLaMasParecida(it, _separarPalabras);
        return Integer.valueOf(Buscador.this.levenshtein(_seleccionarLaMasParecida, it));
      }
    };
    List<Integer> _map = ListExtensions.<String, Integer>map(((List<String>)Conversions.doWrapArray(_separarPalabras)), _function);
    final Function2<Integer, Integer, Integer> _function_1 = new Function2<Integer, Integer, Integer>() {
      public Integer apply(final Integer num1, final Integer num2) {
        return Integer.valueOf(((num1).intValue() + (num2).intValue()));
      }
    };
    return (int) IterableExtensions.<Integer, Integer>fold(_map, Integer.valueOf(0), _function_1);
  }
  
  public PuntoDeInteres puntoMasSemejanteA(final String str1, final PuntoDeInteres punto1, final PuntoDeInteres punto2) {
    PuntoDeInteres _xifexpression = null;
    int _puntajeTotalDelPunto = this.puntajeTotalDelPunto(punto1, str1);
    int _puntajeTotalDelPunto_1 = this.puntajeTotalDelPunto(punto2, str1);
    boolean _lessThan = (_puntajeTotalDelPunto < _puntajeTotalDelPunto_1);
    if (_lessThan) {
      _xifexpression = punto1;
    } else {
      _xifexpression = punto2;
    }
    return _xifexpression;
  }
  
  public Collection<PuntoDeInteres> ordenarPuntosSegunSemejanzaA(final String str1) {
    final Function1<PuntoDeInteres, Boolean> _function = new Function1<PuntoDeInteres, Boolean>() {
      public Boolean apply(final PuntoDeInteres it) {
        String _listaDeTags = it.listaDeTags();
        String[] _separarPalabras = Buscador.this.separarPalabras(_listaDeTags);
        final Function1<String, Boolean> _function = new Function1<String, Boolean>() {
          public Boolean apply(final String it) {
            return Boolean.valueOf(Buscador.this.sonParecidas(str1, it));
          }
        };
        return Boolean.valueOf(IterableExtensions.<String>exists(((Iterable<String>)Conversions.doWrapArray(_separarPalabras)), _function));
      }
    };
    Iterable<PuntoDeInteres> _filter = IterableExtensions.<PuntoDeInteres>filter(this.puntos, _function);
    final Comparator<PuntoDeInteres> _function_1 = new Comparator<PuntoDeInteres>() {
      public int compare(final PuntoDeInteres p1, final PuntoDeInteres p2) {
        int _xifexpression = (int) 0;
        int _puntajeTotalDelPunto = Buscador.this.yo.puntajeTotalDelPunto(p1, str1);
        int _puntajeTotalDelPunto_1 = Buscador.this.yo.puntajeTotalDelPunto(p2, str1);
        boolean _lessThan = (_puntajeTotalDelPunto < _puntajeTotalDelPunto_1);
        if (_lessThan) {
          _xifexpression = 1;
        } else {
          _xifexpression = (-1);
        }
        return _xifexpression;
      }
    };
    return IterableExtensions.<PuntoDeInteres>sortWith(_filter, _function_1);
  }
  
  public PuntoDeInteres[] topTenDePuntos(final String str1) {
    Collection<PuntoDeInteres> _ordenarPuntosSegunSemejanzaA = this.ordenarPuntosSegunSemejanzaA(str1);
    return ((PuntoDeInteres[])Conversions.unwrapArray(IterableExtensions.<PuntoDeInteres>take(_ordenarPuntosSegunSemejanzaA, 10), PuntoDeInteres.class));
  }
  
  @Pure
  public Buscador getYo() {
    return this.yo;
  }
  
  @Pure
  public HashSet<PuntoDeInteres> getPuntos() {
    return this.puntos;
  }
  
  public void setPuntos(final HashSet<PuntoDeInteres> puntos) {
    this.puntos = puntos;
  }
}
