package dominio;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;
import dominio.Direccion;
import dominio.Horario;
import dominio.Servicio;
import dominio.Turno;
import excepciones.NoValidoException;
import java.lang.reflect.Field;
import java.util.HashSet;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.joda.time.DateTime;
import org.uqbar.geodds.Point;

@Accessors
@SuppressWarnings("all")
public abstract class PuntoDeInteres {
  private Direccion direccion;
  
  private String nombre;
  
  private Horario horario;
  
  private HashSet<Servicio> servicios;
  
  private double DISTANCIA_MAXIMA = 0.5;
  
  public String listaDeTags() {
    String _concat = this.nombre.concat(" ");
    String _listaDeTags = this.direccion.listaDeTags();
    return _concat.concat(_listaDeTags);
  }
  
  public boolean estaCercaDe(final Point coordenadasDestino) {
    Point _coordenadas = this.direccion.getCoordenadas();
    double _distance = _coordenadas.distance(coordenadasDestino);
    return (_distance < this.DISTANCIA_MAXIMA);
  }
  
  public boolean estaDisponible(final DateTime unMomento, final String nombreDeServicio) {
    return this.horario.esHabilElMomento(unMomento);
  }
  
  public Horario horarioDeTodosSusServicios(final HashSet<Servicio> servicios) {
    HashSet<Horario.Dia> _juntarDiasDeServicios = this.juntarDiasDeServicios(servicios);
    HashSet<Turno> _juntarTurnosDeServicios = this.juntarTurnosDeServicios(servicios);
    return new Horario(_juntarDiasDeServicios, _juntarTurnosDeServicios);
  }
  
  public HashSet<Horario.Dia> juntarDiasDeServicios(final HashSet<Servicio> servicios) {
    final Function1<Servicio, HashSet<Horario.Dia>> _function = new Function1<Servicio, HashSet<Horario.Dia>>() {
      public HashSet<Horario.Dia> apply(final Servicio unServicio) {
        Horario _horario = unServicio.getHorario();
        return _horario.getDiasHabilesPoi();
      }
    };
    Iterable<HashSet<Horario.Dia>> _map = IterableExtensions.<Servicio, HashSet<Horario.Dia>>map(servicios, _function);
    Iterable<Horario.Dia> _flatten = Iterables.<Horario.Dia>concat(_map);
    return Sets.<Horario.Dia>newHashSet(_flatten);
  }
  
  public HashSet<Turno> juntarTurnosDeServicios(final HashSet<Servicio> servicios) {
    final Function1<Servicio, HashSet<Turno>> _function = new Function1<Servicio, HashSet<Turno>>() {
      public HashSet<Turno> apply(final Servicio unServicio) {
        Horario _horario = unServicio.getHorario();
        return _horario.getTurnosDisponibles();
      }
    };
    Iterable<HashSet<Turno>> _map = IterableExtensions.<Servicio, HashSet<Turno>>map(servicios, _function);
    Iterable<Turno> _flatten = Iterables.<Turno>concat(_map);
    return Sets.<Turno>newHashSet(_flatten);
  }
  
  public void validate() {
    try {
      Field[] _declaredFields = PuntoDeInteres.class.getDeclaredFields();
      final Function1<Field, Boolean> _function = new Function1<Field, Boolean>() {
        public Boolean apply(final Field field) {
          try {
            boolean _xblockexpression = false;
            {
              field.setAccessible(true);
              Object _get = field.get(PuntoDeInteres.this);
              _xblockexpression = Objects.equal(_get, null);
            }
            return Boolean.valueOf(_xblockexpression);
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        }
      };
      boolean _exists = IterableExtensions.<Field>exists(((Iterable<Field>)Conversions.doWrapArray(_declaredFields)), _function);
      if (_exists) {
        throw new NoValidoException("El Poi no es valido");
      } else {
        this.direccion.validate();
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
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
  
  @Pure
  public HashSet<Servicio> getServicios() {
    return this.servicios;
  }
  
  public void setServicios(final HashSet<Servicio> servicios) {
    this.servicios = servicios;
  }
  
  @Pure
  public double getDISTANCIA_MAXIMA() {
    return this.DISTANCIA_MAXIMA;
  }
  
  public void setDISTANCIA_MAXIMA(final double DISTANCIA_MAXIMA) {
    this.DISTANCIA_MAXIMA = DISTANCIA_MAXIMA;
  }
}
