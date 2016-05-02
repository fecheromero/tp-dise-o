package dominio;

import com.google.common.base.Objects;
import dominio.Direccion;
import dominio.Horario;
import dominio.PuntoDeInteres;
import dominio.Rubro;
import excepciones.NoValidoException;
import java.lang.reflect.Field;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class LocalComercial extends PuntoDeInteres {
  private Rubro rubro;
  
  public String listaDeTags() {
    String _listaDeTags = super.listaDeTags();
    String _nombre = this.rubro.getNombre();
    String _concat = " ".concat(_nombre);
    return _listaDeTags.concat(_concat);
  }
  
  public LocalComercial(final String _nombre, final Horario _horario, final Direccion _direccion, final Rubro _rubro) {
    this.setNombre(_nombre);
    this.setHorario(_horario);
    this.setDireccion(_direccion);
    this.rubro = _rubro;
  }
  
  public void validate() {
    try {
      Field[] _declaredFields = PuntoDeInteres.class.getDeclaredFields();
      final Function1<Field, Boolean> _function = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          String _name = field.getName();
          return Boolean.valueOf((!Objects.equal(_name, "servicios")));
        }
      };
      Iterable<Field> _filter = IterableExtensions.<Field>filter(((Iterable<Field>)Conversions.doWrapArray(_declaredFields)), _function);
      final Function1<Field, Boolean> _function_1 = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          try {
            boolean _xblockexpression = false;
            {
              field.setAccessible(true);
              Object _get = field.get(LocalComercial.this);
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
  
  @Pure
  public Rubro getRubro() {
    return this.rubro;
  }
  
  public void setRubro(final Rubro rubro) {
    this.rubro = rubro;
  }
}
