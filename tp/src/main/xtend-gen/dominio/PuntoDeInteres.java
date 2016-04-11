package dominio;

import dominio.Direccion;
import dominio.Horario;
import dominio.Momento;
import java.util.Collections;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.geodds.Point;

@Accessors
@SuppressWarnings("all")
public abstract class PuntoDeInteres {
  private Direccion direccion;
  
  private String nombre;
  
  private Horario horario;
  
  private static double DISTANCIA_MAXIMA = 0.5;
  
  public String listaDeTags() {
    String _xblockexpression = null;
    {
      String lista = "";
      String _listaDeTags = this.direccion.listaDeTags();
      final Function2<String, String, String> _function = new Function2<String, String, String>() {
        public String apply(final String palabra1, final String palabra2) {
          String _concat = palabra1.concat(" ");
          return _concat.concat(palabra2);
        }
      };
      String _fold = IterableExtensions.<String, String>fold(Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList(this.nombre, _listaDeTags)), "", _function);
      _xblockexpression = lista.concat(_fold);
    }
    return _xblockexpression;
  }
  
  public boolean estaCercaDe(final Point coordenadasDestino) {
    Point _coordenadas = this.direccion.getCoordenadas();
    double _distance = _coordenadas.distance(coordenadasDestino);
    return (_distance < PuntoDeInteres.DISTANCIA_MAXIMA);
  }
  
  public abstract boolean estaDisponible(final Momento unMomento);
  
  public abstract boolean estaDisponible(final Momento unMomento, final String nombreDeServicio);
  
  public void setearDiasHabiles(final List<String> diasHabiles) {
    this.horario.setearDiasHabiles(diasHabiles);
  }
  
  @Pure
  public Direccion getDireccion() {
    return this.direccion;
  }
  
  public void setDireccion(final Direccion direccion) {
    this.direccion = direccion;
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
