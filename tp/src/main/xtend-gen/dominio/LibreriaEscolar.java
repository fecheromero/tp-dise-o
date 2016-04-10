package dominio;

import dominio.Direccion;
import dominio.LocalComercial;

@SuppressWarnings("all")
public class LibreriaEscolar extends LocalComercial {
  private static double DISTANCIA_MAXIMA = 500;
  
  public LibreriaEscolar(final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
  }
}
