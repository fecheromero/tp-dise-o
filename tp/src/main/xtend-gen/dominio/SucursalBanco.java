package dominio;

import dominio.Direccion;
import dominio.Horario;
import dominio.PuntoDeInteresConServicios;
import dominio.Servicio;
import dominio.Turno;
import java.util.HashSet;
import org.eclipse.xtext.xbase.lib.CollectionExtensions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.joda.time.DateTime;
import org.joda.time.LocalTime;

@SuppressWarnings("all")
public class SucursalBanco extends PuntoDeInteresConServicios {
  private HashSet<Servicio> servicios;
  
  public SucursalBanco(final HashSet<Servicio> servicios, final Direccion _direccion, final String _nombre) {
    super(servicios, _direccion, _nombre);
    HashSet<Turno> turnosDisponiblesBanco = new HashSet<Turno>();
    HashSet<Integer> diasHabilesBanco = new HashSet<Integer>();
    LocalTime _localTime = new LocalTime(10, 0);
    LocalTime _localTime_1 = new LocalTime(15, 0);
    Turno turnoBanco = new Turno(_localTime, _localTime_1);
    turnosDisponiblesBanco.add(turnoBanco);
    CollectionExtensions.<Integer>addAll(diasHabilesBanco, Integer.valueOf(1), Integer.valueOf(2), Integer.valueOf(3), Integer.valueOf(4), Integer.valueOf(5));
    Horario _horario = new Horario(diasHabilesBanco, turnosDisponiblesBanco);
    this.setHorario(_horario);
  }
  
  public boolean estaDisponible(final DateTime unMomento, final String nombreDeServicio) {
    return this.estaDisponible(unMomento);
  }
  
  public String listaDeTags() {
    String _listaDeTags = super.listaDeTags();
    final Function1<Servicio, String> _function = new Function1<Servicio, String>() {
      public String apply(final Servicio servicio) {
        return servicio.listaDeTags();
      }
    };
    Iterable<String> _map = IterableExtensions.<Servicio, String>map(this.servicios, _function);
    String _string = _map.toString();
    String _concat = " ".concat(_string);
    return _listaDeTags.concat(_concat);
  }
}
