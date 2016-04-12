package dominio;

import dominio.Direccion;
import dominio.Horario;
import dominio.PuntoDeInteres;
import dominio.Servicio;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.joda.time.DateTime;

@Accessors
@SuppressWarnings("all")
public class SucursalBanco extends PuntoDeInteres {
  private List<Servicio> servicios;
  
  public SucursalBanco(final List<Servicio> servicios, final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
    this.servicios = servicios;
  }
  
  public String listaDeTags() {
    String _listaDeTags = super.listaDeTags();
    final Function1<Servicio, String> _function = new Function1<Servicio, String>() {
      public String apply(final Servicio servicio) {
        return servicio.listaDeTags();
      }
    };
    List<String> _map = ListExtensions.<Servicio, String>map(this.servicios, _function);
    String _string = _map.toString();
    String _concat = " ".concat(_string);
    return _listaDeTags.concat(_concat);
  }
  
  public boolean estaDisponible(final DateTime unMomento) {
    Horario _horario = this.getHorario();
    return _horario.esHabilElMomento(unMomento);
  }
  
  @Pure
  public List<Servicio> getServicios() {
    return this.servicios;
  }
  
  public void setServicios(final List<Servicio> servicios) {
    this.servicios = servicios;
  }
}
