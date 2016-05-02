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
  public enum Dia {
    LUN,
    
    MAR,
    
    MIE,
    
    JUE,
    
    VIE,
    
    SAB,
    
    DOM;
  }
  
  private HashSet<Horario.Dia> diasHabilesPoi;
  
  private HashSet<Turno> turnosDisponibles;
  
  public int transformarANum(final Horario.Dia unDia) {
    int _switchResult = (int) 0;
    if (unDia != null) {
      switch (unDia) {
        case LUN:
          _switchResult = 1;
          break;
        case MAR:
          _switchResult = 2;
          break;
        case MIE:
          _switchResult = 3;
          break;
        case JUE:
          _switchResult = 4;
          break;
        case VIE:
          _switchResult = 5;
          break;
        case SAB:
          _switchResult = 6;
          break;
        case DOM:
          _switchResult = 7;
          break;
        default:
          break;
      }
    }
    return _switchResult;
  }
  
  public Horario(final HashSet<Horario.Dia> _diashabiles, final HashSet<Turno> _turnos) {
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
    final Function1<Horario.Dia, Integer> _function = new Function1<Horario.Dia, Integer>() {
      public Integer apply(final Horario.Dia dia) {
        return Integer.valueOf(Horario.this.transformarANum(dia));
      }
    };
    Iterable<Integer> _map = IterableExtensions.<Horario.Dia, Integer>map(this.diasHabilesPoi, _function);
    final Function1<Integer, Boolean> _function_1 = new Function1<Integer, Boolean>() {
      public Boolean apply(final Integer dia) {
        int _dayOfWeek = unMomento.getDayOfWeek();
        return Boolean.valueOf(((dia).intValue() == _dayOfWeek));
      }
    };
    return IterableExtensions.<Integer>exists(_map, _function_1);
  }
  
  @Pure
  public HashSet<Horario.Dia> getDiasHabilesPoi() {
    return this.diasHabilesPoi;
  }
  
  public void setDiasHabilesPoi(final HashSet<Horario.Dia> diasHabilesPoi) {
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
