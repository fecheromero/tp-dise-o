package dominio;

import dominio.Comuna;
import dominio.Direccion;
import dominio.PuntoDeInteresConServicios;
import dominio.Servicio;
import java.util.HashSet;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@Accessors
@SuppressWarnings("all")
public class CGP extends PuntoDeInteresConServicios {
  public String listaDeTags() {
    String _listaDeTags = super.listaDeTags();
    HashSet<Servicio> _servicios = this.getServicios();
    final Function1<Servicio, String> _function = new Function1<Servicio, String>() {
      public String apply(final Servicio servicio) {
        return servicio.listaDeTags();
      }
    };
    Iterable<String> _map = IterableExtensions.<Servicio, String>map(_servicios, _function);
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
  
  public CGP(final HashSet<Servicio> servicios, final Direccion _direccion, final String _nombre) {
    super(servicios, _direccion, _nombre);
  }
}
