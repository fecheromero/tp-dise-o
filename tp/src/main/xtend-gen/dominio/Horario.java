package dominio;

import dominio.Turno;
import java.util.Set;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.joda.time.DateTime;
import org.joda.time.LocalTime;

@SuppressWarnings("all")
public class Horario {
  private Set<Integer> diasHabilesPoi;
  
  private Set<Turno> turnosDisponibles;
  
  public void setearDiasHabiles(final Set<Integer> diasHabiles) {
    this.diasHabilesPoi = diasHabiles;
  }
  
  public void setearTurnosDisponibles(final Set<Turno> turnos) {
    this.turnosDisponibles = turnos;
  }
  
  public boolean esHabilElMomento(final DateTime unMomento) {
    boolean _and = false;
    boolean _estaEnDiaHabil = this.estaEnDiaHabil(unMomento);
    if (!_estaEnDiaHabil) {
      _and = false;
    } else {
      boolean _estaDentroDeUnTurno = this.estaDentroDeUnTurno(unMomento);
      _and = _estaDentroDeUnTurno;
    }
    return _and;
  }
  
  public boolean estaDentroDeUnTurno(final DateTime unMomento) {
    final Function1<Turno, Boolean> _function = new Function1<Turno, Boolean>() {
      public Boolean apply(final Turno unTurno) {
        LocalTime _horaDelMomento = Horario.this.horaDelMomento(unMomento);
        return Boolean.valueOf(unTurno.horaDentroDelTurno(_horaDelMomento));
      }
    };
    return IterableExtensions.<Turno>exists(this.turnosDisponibles, _function);
  }
  
  public LocalTime horaDelMomento(final DateTime unMomento) {
    return unMomento.toLocalTime();
  }
  
  public boolean estaEnDiaHabil(final DateTime unMomento) {
    final Function1<Integer, Boolean> _function = new Function1<Integer, Boolean>() {
      public Boolean apply(final Integer unDia) {
        int _dayOfWeek = unMomento.getDayOfWeek();
        return Boolean.valueOf(((unDia).intValue() == _dayOfWeek));
      }
    };
    return IterableExtensions.<Integer>exists(this.diasHabilesPoi, _function);
  }
}
