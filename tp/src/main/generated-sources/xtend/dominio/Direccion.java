package dominio;

import com.google.common.base.Objects;
import dependencias.Tageador;
import dominio.Comuna;
import excepciones.NoValidoException;
import java.lang.reflect.Field;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.geodds.Point;

@Accessors
@SuppressWarnings("all")
public class Direccion {
  private String callePrincipal;
  
  private String numero;
  
  private String[] entre;
  
  private Point coordenadas;
  
  private String localidad;
  
  private String provincia;
  
  private Comuna comuna;
  
  private String codigoPostal;
  
  private String piso;
  
  private String departamento;
  
  private String unidad;
  
  private Tageador tag = new Tageador();
  
  public Direccion(final String callePrincipal, final String numero, final String[] entre, final Point coordenadas, final String localidad, final String provincia, final Comuna comuna, final String codigoPostal, final String piso, final String departamento, final String unidad) {
    this.callePrincipal = callePrincipal;
    this.numero = numero;
    this.entre = entre;
    this.coordenadas = coordenadas;
    this.localidad = localidad;
    this.provincia = provincia;
    this.comuna = comuna;
    this.codigoPostal = codigoPostal;
    this.piso = piso;
    this.departamento = departamento;
    this.unidad = unidad;
  }
  
  public String listaDeTags() {
    String _tagear = this.tag.tagear(this);
    String _tagear_1 = this.tag.tagear(this.comuna);
    String _concat = _tagear.concat(_tagear_1);
    String _get = this.entre[0];
    String _concat_1 = _concat.concat(_get);
    String _concat_2 = _concat_1.concat(" ");
    String _get_1 = this.entre[1];
    return _concat_2.concat(_get_1);
  }
  
  public void validate() {
    try {
      Field[] _declaredFields = Direccion.class.getDeclaredFields();
      final Function1<Field, Boolean> _function = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          try {
            boolean _xblockexpression = false;
            {
              field.setAccessible(true);
              Object _get = field.get(Direccion.this);
              _xblockexpression = Objects.equal(_get, null);
            }
            return Boolean.valueOf(_xblockexpression);
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        }
      };
      boolean _exists = IterableExtensions.<Field>exists(((Iterable<Field>)Conversions.doWrapArray(_declaredFields)), _function);
      if (_exists) {
        throw new NoValidoException("La direccion no es valida");
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  @Pure
  public String getCallePrincipal() {
    return this.callePrincipal;
  }
  
  public void setCallePrincipal(final String callePrincipal) {
    this.callePrincipal = callePrincipal;
  }
  
  @Pure
  public String getNumero() {
    return this.numero;
  }
  
  public void setNumero(final String numero) {
    this.numero = numero;
  }
  
  @Pure
  public String[] getEntre() {
    return this.entre;
  }
  
  public void setEntre(final String[] entre) {
    this.entre = entre;
  }
  
  @Pure
  public Point getCoordenadas() {
    return this.coordenadas;
  }
  
  public void setCoordenadas(final Point coordenadas) {
    this.coordenadas = coordenadas;
  }
  
  @Pure
  public String getLocalidad() {
    return this.localidad;
  }
  
  public void setLocalidad(final String localidad) {
    this.localidad = localidad;
  }
  
  @Pure
  public String getProvincia() {
    return this.provincia;
  }
  
  public void setProvincia(final String provincia) {
    this.provincia = provincia;
  }
  
  @Pure
  public Comuna getComuna() {
    return this.comuna;
  }
  
  public void setComuna(final Comuna comuna) {
    this.comuna = comuna;
  }
  
  @Pure
  public String getCodigoPostal() {
    return this.codigoPostal;
  }
  
  public void setCodigoPostal(final String codigoPostal) {
    this.codigoPostal = codigoPostal;
  }
  
  @Pure
  public String getPiso() {
    return this.piso;
  }
  
  public void setPiso(final String piso) {
    this.piso = piso;
  }
  
  @Pure
  public String getDepartamento() {
    return this.departamento;
  }
  
  public void setDepartamento(final String departamento) {
    this.departamento = departamento;
  }
  
  @Pure
  public String getUnidad() {
    return this.unidad;
  }
  
  public void setUnidad(final String unidad) {
    this.unidad = unidad;
  }
  
  @Pure
  public Tageador getTag() {
    return this.tag;
  }
  
  public void setTag(final Tageador tag) {
    this.tag = tag;
  }
}
