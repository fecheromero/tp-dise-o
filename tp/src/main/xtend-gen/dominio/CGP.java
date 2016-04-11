package dominio;

import com.google.common.base.Objects;
import dominio.Comuna;
import dominio.Direccion;
import dominio.Momento;
import dominio.PuntoDeInteres;
import dominio.Servicio;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@Accessors
@SuppressWarnings("all")
public class CGP extends PuntoDeInteres {
  private List<Servicio> servicios;
  
  public CGP(final List<Servicio> servicios, final Direccion _direccion, final String _nombre) {
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
  
  public boolean estaCercaDe(final Point coordenadasDestino) {
    Direccion _direccion = this.getDireccion();
    Comuna _comuna = _direccion.getComuna();
    Polygon _poligono = _comuna.getPoligono();
    return _poligono.isInside(coordenadasDestino);
  }
  
  public boolean estaDisponible(final Momento unMomento) {
    return this.algunServicioEstaDisponibleEn(unMomento);
  }
  
  public boolean estaDisponible(final Momento unMomento, final String nombreDeServicio) {
    return this.estaDisponibleElServicio(unMomento, nombreDeServicio);
  }
  
  public boolean algunServicioEstaDisponibleEn(final Momento unMomento) {
    final Function1<Servicio, Boolean> _function = new Function1<Servicio, Boolean>() {
      public Boolean apply(final Servicio unServicio) {
        return Boolean.valueOf(unServicio.estaDisponible(unMomento));
      }
    };
    return IterableExtensions.<Servicio>exists(this.servicios, _function);
  }
  
  public boolean estaDisponibleElServicio(final Momento unMomento, final String nombreDeServicio) {
    Servicio _buscarServicioDeNombre = this.buscarServicioDeNombre(nombreDeServicio);
    return _buscarServicioDeNombre.estaDisponible(unMomento);
  }
  
  public Servicio buscarServicioDeNombre(final String nombreDeServicio) {
    final Function1<Servicio, Boolean> _function = new Function1<Servicio, Boolean>() {
      public Boolean apply(final Servicio unServicio) {
        String _nombre = unServicio.getNombre();
        return Boolean.valueOf(Objects.equal(_nombre, nombreDeServicio));
      }
    };
    return IterableExtensions.<Servicio>findFirst(this.servicios, _function);
  }
  
  @Pure
  public List<Servicio> getServicios() {
    return this.servicios;
  }
  
  public void setServicios(final List<Servicio> servicios) {
    this.servicios = servicios;
  }
}
