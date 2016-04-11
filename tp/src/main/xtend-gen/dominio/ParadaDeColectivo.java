package dominio;

import dominio.Direccion;
import dominio.Momento;
import dominio.PuntoDeInteres;
import org.eclipse.xtend.lib.annotations.Accessors;

@Accessors
@SuppressWarnings("all")
public class ParadaDeColectivo extends PuntoDeInteres {
  private static double DISTANCIA_MAXIMA = 0.1;
  
  public ParadaDeColectivo(final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
  }
  
  public boolean estaDisponible(final Momento unMomento) {
    return true;
  }
  
  public boolean estaDisponible(final Momento unMomento, final String nombreDeServicio) {
    return true;
  }
}
