package dominio;

import dominio.Direccion;
import dominio.PuntoDeInteres;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.joda.time.DateTime;

@Accessors
@SuppressWarnings("all")
public class ParadaDeColectivo extends PuntoDeInteres {
  public ParadaDeColectivo(final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
    this.setDISTANCIA_MAXIMA(0.1);
  }
  
  public boolean estaDisponible(final DateTime unMomento) {
    return true;
  }
}
