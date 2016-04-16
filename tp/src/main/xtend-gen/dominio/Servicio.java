package dominio;

import dominio.Horario;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Servicio {
  private String nombre;
  
  private Horario horario;
  
  public Servicio(final String _nombre, final Horario _horario) {
    this.nombre = _nombre;
    this.horario = _horario;
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
  public Horario getHorario() {
    return this.horario;
  }
  
  public void setHorario(final Horario horario) {
    this.horario = horario;
  }
}
