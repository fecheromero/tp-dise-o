package dominio;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Rubro {
  private String nombre;
  
  private double DISTANCIA_MAXIMA;
  
  public Rubro(final String _nombre, final Double _distanciamaxima) {
    this.nombre = _nombre;
    this.DISTANCIA_MAXIMA = (_distanciamaxima).doubleValue();
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public double getDISTANCIA_MAXIMA() {
    return this.DISTANCIA_MAXIMA;
  }
  
  public void setDISTANCIA_MAXIMA(final double DISTANCIA_MAXIMA) {
    this.DISTANCIA_MAXIMA = DISTANCIA_MAXIMA;
  }
}
