package dominio;

import dominio.Turno;
import java.util.HashSet;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.joda.time.DateTime;
import org.joda.time.LocalTime;

@Accessors
@SuppressWarnings("all")
public class Horario {
  private HashSet<Integer> diasHabilesPoi;
  
  private HashSet<Turno> turnosDisponibles;
  
  public Horario(final HashSet<Integer> _diashabiles, final HashSet<Turno> _turnos) {
    this.diasHabilesPoi = _diashabiles;
    this.turnosDisponibles = _turnos;
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
    int _dayOfWeek = unMomento.getDayOfWeek();
    return this.diasHabilesPoi.contains(Integer.valueOf(_dayOfWeek));
  }
  
  @Pure
  public HashSet<Integer> getDiasHabilesPoi() {
    return this.diasHabilesPoi;
  }
  
  public void setDiasHabilesPoi(final HashSet<Integer> diasHabilesPoi) {
    this.diasHabilesPoi = diasHabilesPoi;
  }
  
  @Pure
  public HashSet<Turno> getTurnosDisponibles() {
    return this.turnosDisponibles;
  }
  
  public void setTurnosDisponibles(final HashSet<Turno> turnosDisponibles) {
    this.turnosDisponibles = turnosDisponibles;
  }
}
