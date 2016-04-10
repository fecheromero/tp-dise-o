package dominio;

import dominio.Direccion;
import dominio.LocalComercial;
import org.eclipse.xtend.lib.annotations.Accessors;

@Accessors
@SuppressWarnings("all")
public class KioscoDiarios extends LocalComercial {
  private static double DISTANCIA_MAXIMA = 200;
  
  public KioscoDiarios(final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
  }
}
