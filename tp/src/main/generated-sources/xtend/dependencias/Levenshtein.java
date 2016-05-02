package dependencias;

import java.util.List;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.ListExtensions;

@SuppressWarnings("all")
public class Levenshtein {
  public int minimum(final int a, final int b, final int c) {
    if (((a <= b) && (a <= c))) {
      return a;
    }
    if (((b <= a) && (b <= c))) {
      return b;
    }
    return c;
  }
  
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
    int[][] distance = Levenshtein.newIntArrayOfSize(_plus, _plus_1);
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
}
