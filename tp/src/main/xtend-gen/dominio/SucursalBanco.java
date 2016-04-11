package dominio;

import dominio.Direccion;
import dominio.Horario;
import dominio.Momento;
import dominio.PuntoDeInteres;
import dominio.Servicio;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class SucursalBanco extends PuntoDeInteres {
  private List<Servicio> servicios;
  
  public SucursalBanco(final List<Servicio> servicios, final Direccion _direccion, final String _nombre) {
    this.setDireccion(_direccion);
    this.setNombre(_nombre);
    this.servicios = servicios;
  }
  
  public boolean estaDisponible(final Momento unMomento) {
    Horario _horario = this.getHorario();
    return _horario.esHabilElMomento(unMomento);
  }
  
  public boolean estaDisponible(final Momento unMomento, final String nombreDeServicio) {
    return this.estaDisponible(unMomento);
  }
  
  @Pure
  public List<Servicio> getServicios() {
    return this.servicios;
  }
  
  public void setServicios(final List<Servicio> servicios) {
    this.servicios = servicios;
  }
}