package dominio;

import com.google.common.base.Objects;
import dominio.Direccion;
import dominio.PuntoDeInteres;
import excepciones.NoValidoException;
import java.lang.reflect.Field;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.joda.time.DateTime;

@Accessors
@SuppressWarnings("all")
public class ParadaDeColectivo extends PuntoDeInteres {
  public ParadaDeColectivo(final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
    this.setDISTANCIA_MAXIMA(0.1);
  }
  
  public boolean estaDisponible(final DateTime unMomento, final String nombreDeServicio) {
    return true;
  }
  
  public void validate() {
    try {
      Field[] _declaredFields = PuntoDeInteres.class.getDeclaredFields();
      final Function1<Field, Boolean> _function = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          boolean _and = false;
          String _name = field.getName();
          boolean _notEquals = (!Objects.equal(_name, "servicios"));
          if (!_notEquals) {
            _and = false;
          } else {
            String _name_1 = field.getName();
            boolean _notEquals_1 = (!Objects.equal(_name_1, "horario"));
            _and = _notEquals_1;
          }
          return Boolean.valueOf(_and);
        }
      };
      Iterable<Field> _filter = IterableExtensions.<Field>filter(((Iterable<Field>)Conversions.doWrapArray(_declaredFields)), _function);
      final Function1<Field, Boolean> _function_1 = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          try {
            boolean _xblockexpression = false;
            {
              field.setAccessible(true);
              Object _get = field.get(ParadaDeColectivo.this);
              _xblockexpression = Objects.equal(_get, null);
            }
            return Boolean.valueOf(_xblockexpression);
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        }
      };
      boolean _exists = IterableExtensions.<Field>exists(_filter, _function_1);
      if (_exists) {
        throw new NoValidoException("El Poi no es valido");
      } else {
        Direccion _direccion = this.getDireccion();
        _direccion.validate();
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
