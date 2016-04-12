package dominio;

import dominio.Horario;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.joda.time.DateTime;

@Accessors
@SuppressWarnings("all")
public class Servicio {
  private String nombre;
  
  private Horario horario;
  
  public Servicio(final String _nombre) {
    this.nombre = _nombre;
  }
  
  public String listaDeTags() {
    String _xblockexpression = null;
    {
      String lista = null;
      _xblockexpression = lista = this.nombre;
    }
    return _xblockexpression;
  }
  
  public boolean estaDisponible(final DateTime unMomento) {
    return this.horario.esHabilElMomento(unMomento);
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
