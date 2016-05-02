package dominio;

import com.google.common.base.Objects;
import dominio.Direccion;
import dominio.Horario;
import dominio.PuntoDeInteres;
import dominio.Servicio;
import dominio.Turno;
import excepciones.NoValidoException;
import java.util.HashSet;
import org.eclipse.xtext.xbase.lib.CollectionExtensions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.Functions.Function2;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.joda.time.DateTime;
import org.joda.time.LocalTime;

@SuppressWarnings("all")
public class SucursalBanco extends PuntoDeInteres {
  public SucursalBanco(final HashSet<Servicio> servicios, final Direccion _direccion, final String _nombre) {
    this.setNombre(_nombre);
    this.setDireccion(_direccion);
    this.setServicios(servicios);
    HashSet<Turno> turnosDisponiblesBanco = new HashSet<Turno>();
    HashSet<Horario.Dia> diasHabilesBanco = new HashSet<Horario.Dia>();
    LocalTime _localTime = new LocalTime(10, 0);
    LocalTime _localTime_1 = new LocalTime(15, 0);
    Turno turnoBanco = new Turno(_localTime, _localTime_1);
    turnosDisponiblesBanco.add(turnoBanco);
    CollectionExtensions.<Horario.Dia>addAll(diasHabilesBanco, Horario.Dia.LUN, Horario.Dia.MAR, Horario.Dia.MIE, Horario.Dia.JUE, Horario.Dia.VIE);
    Horario _horario = new Horario(diasHabilesBanco, turnosDisponiblesBanco);
    this.setHorario(_horario);
  }
  
  public boolean estaDisponible(final DateTime unMomento, final String nombreDeServicio) {
    try {
      boolean _xifexpression = false;
      boolean _equals = Objects.equal(nombreDeServicio, "");
      if (_equals) {
        _xifexpression = super.estaDisponible(unMomento, nombreDeServicio);
      } else {
        boolean _xifexpression_1 = false;
        HashSet<Servicio> _servicios = this.getServicios();
        final Function1<Servicio, Boolean> _function = new Function1<Servicio, Boolean>() {
          public Boolean apply(final Servicio servicio) {
            String _nombre = servicio.getNombre();
            return Boolean.valueOf(Objects.equal(_nombre, nombreDeServicio));
          }
        };
        boolean _exists = IterableExtensions.<Servicio>exists(_servicios, _function);
        if (_exists) {
          HashSet<Servicio> _servicios_1 = this.getServicios();
          final Function1<Servicio, Boolean> _function_1 = new Function1<Servicio, Boolean>() {
            public Boolean apply(final Servicio servicio) {
              String _nombre = servicio.getNombre();
              return Boolean.valueOf(Objects.equal(_nombre, nombreDeServicio));
            }
          };
          Servicio _findFirst = IterableExtensions.<Servicio>findFirst(_servicios_1, _function_1);
          _xifexpression_1 = _findFirst.estaDisponible(unMomento);
        } else {
          throw new NoValidoException("No se encuentra el servicio");
        }
        _xifexpression = _xifexpression_1;
      }
      return _xifexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public String listaDeTags() {
    String _listaDeTags = super.listaDeTags();
    HashSet<Servicio> _servicios = this.getServicios();
    final Function1<Servicio, String> _function = new Function1<Servicio, String>() {
      public String apply(final Servicio servicio) {
        return servicio.getNombre();
      }
    };
    Iterable<String> _map = IterableExtensions.<Servicio, String>map(_servicios, _function);
    final Function2<String, String, String> _function_1 = new Function2<String, String, String>() {
      public String apply(final String serv1, final String serv2) {
        return serv1.concat(serv2);
      }
    };
    String _fold = IterableExtensions.<String, String>fold(_map, "", _function_1);
    String _concat = " ".concat(_fold);
    return _listaDeTags.concat(_concat);
  }
}
