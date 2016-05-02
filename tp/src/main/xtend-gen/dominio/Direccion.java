package dominio;

import dominio.Comuna;
import java.util.Collections;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
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
    String _xblockexpression = null;
    {
      String lista = "";
      String _get = this.entre[0];
      String _get_1 = this.entre[1];
      String _listaDeTags = this.comuna.listaDeTags();
      final Function2<String, String, String> _function = new Function2<String, String, String>() {
        public String apply(final String palabra1, final String palabra2) {
          String _concat = palabra1.concat(" ");
          return _concat.concat(palabra2);
        }
      };
      String _fold = IterableExtensions.<String, String>fold(Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList(this.callePrincipal, this.numero, _get, _get_1, this.localidad, this.provincia, _listaDeTags, this.codigoPostal, this.piso, this.departamento, this.unidad)), "", _function);
      _xblockexpression = lista.concat(_fold);
    }
    return _xblockexpression;
  }
  
  public Point getCoordenadas() {
    return this.coordenadas;
  }
  
  public Comuna getComuna() {
    return this.comuna;
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
}
