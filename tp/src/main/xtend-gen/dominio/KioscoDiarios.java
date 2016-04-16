package dominio;

import dominio.Direccion;
import dominio.Horario;
import dominio.LocalComercial;
import org.eclipse.xtend.lib.annotations.Accessors;

@Accessors
@SuppressWarnings("all")
public class KioscoDiarios extends LocalComercial {
  public KioscoDiarios(final String _nombre, final Horario _horario, final Direccion _direccion) {
    this.setHorario(_horario);
    this.setNombre(_nombre);
    this.setDireccion(_direccion);
    this.setDISTANCIA_MAXIMA(0.2);
    this.setRubro("kiosco");
  }
}
