package dominio;

import dominio.Direccion;
import dominio.PuntoDeInteres;
import org.eclipse.xtend.lib.annotations.Accessors;

@Accessors
@SuppressWarnings("all")
public class ParadaDeColectivo extends PuntoDeInteres {
  private static double DISTANCIA_MAXIMA = 100;
  
  public ParadaDeColectivo(final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
  }
}
