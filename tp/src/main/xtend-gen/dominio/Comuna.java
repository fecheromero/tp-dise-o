package dominio;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.geodds.Polygon;

@Accessors
@SuppressWarnings("all")
public class Comuna {
  private String nombre;
  
  private Polygon poligono;
  
  public Comuna(final String nombre, final Polygon poligono) {
    this.nombre = nombre;
    this.poligono = poligono;
  }
  
  public String listaDeTags() {
    String _xblockexpression = null;
    {
      String lista = null;
      _xblockexpression = lista = this.nombre;
    }
    return _xblockexpression;
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public Polygon getPoligono() {
    return this.poligono;
  }
  
  public void setPoligono(final Polygon poligono) {
    this.poligono = poligono;
  }
}
