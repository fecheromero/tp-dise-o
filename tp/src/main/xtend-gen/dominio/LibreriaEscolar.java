package dominio;

import dominio.Direccion;
import dominio.Horario;
import dominio.LocalComercial;

@SuppressWarnings("all")
public class LibreriaEscolar extends LocalComercial {
  public LibreriaEscolar(final String _nombre, final Horario _horario, final Direccion _direccion) {
    this.setHorario(_horario);
    this.setNombre(_nombre);
    this.setDireccion(_direccion);
    this.setRubro("libreria");
  }
}
