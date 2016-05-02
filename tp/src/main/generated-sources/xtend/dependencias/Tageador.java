package dependencias;

import com.google.common.base.Objects;
import java.lang.reflect.Field;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class Tageador {
  public String tagear(final Object obj) {
    String _xblockexpression = null;
    {
      String lista = "";
      Class<?> _class = obj.getClass();
      Field[] listaDeCampos = _class.getDeclaredFields();
      final Field[] _converted_listaDeCampos = (Field[])listaDeCampos;
      final Consumer<Field> _function = new Consumer<Field>() {
        public void accept(final Field field) {
          field.setAccessible(true);
        }
      };
      ((List<Field>)Conversions.doWrapArray(_converted_listaDeCampos)).forEach(_function);
      final Field[] _converted_listaDeCampos_1 = (Field[])listaDeCampos;
      final Function1<Field, Boolean> _function_1 = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          Class<?> _type = field.getType();
          return Boolean.valueOf(Objects.equal(_type, String.class));
        }
      };
      Iterable<Field> _filter = IterableExtensions.<Field>filter(((Iterable<Field>)Conversions.doWrapArray(_converted_listaDeCampos_1)), _function_1);
      final Function1<Field, String> _function_2 = new Function1<Field, String>() {
        public String apply(final Field field) {
          try {
            Object _get = field.get(obj);
            return _get.toString();
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        }
      };
      Iterable<String> _map = IterableExtensions.<Field, String>map(_filter, _function_2);
      final Function2<String, String, String> _function_3 = new Function2<String, String, String>() {
        public String apply(final String palabra1, final String palabra2) {
          String _concat = palabra1.concat(" ");
          return _concat.concat(palabra2);
        }
      };
      String _fold = IterableExtensions.<String, String>fold(_map, "", _function_3);
      _xblockexpression = lista.concat(_fold);
    }
    return _xblockexpression;
  }
}
