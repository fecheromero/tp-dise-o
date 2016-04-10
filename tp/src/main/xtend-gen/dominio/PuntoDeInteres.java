package dominio;

import dominio.Direccion;
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
  
  private static double FACTOR_CONVERSION = 0.001;
  
  private static double DISTANCIA_MAXIMA = 500;
  
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
    return this.verificarCercania(this, coordenadasDestino, PuntoDeInteres.DISTANCIA_MAXIMA);
  }
  
  public boolean verificarCercania(final PuntoDeInteres unPunto, final Point coordenadasDestino, final double distanciaMaxima) {
    double distancia = 0;
    Direccion _direccion = this.getDireccion();
    Point _coordenadas = _direccion.getCoordenadas();
    double _distance = _coordenadas.distance(coordenadasDestino);
    distancia = _distance;
    if (((distancia * PuntoDeInteres.FACTOR_CONVERSION) < PuntoDeInteres.DISTANCIA_MAXIMA)) {
      return true;
    } else {
      return false;
    }
  }
  
  public Direccion getDireccion() {
    return this.direccion;
  }
  
  public abstract boolean estaDisponible(final Momento unMomento);
  
  public abstract boolean estaDisponible(final Momento unMomento, final String nombreDeServicio);
  
  public abstract void setearDiasHabiles(final List<String> diasHabiles);
  
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
}
