package dominio;

import org.joda.time.LocalTime;

@SuppressWarnings("all")
public class Turno {
  private LocalTime horaInicio;
  
  private LocalTime horaFin;
  
  public boolean horaDentroDelTurno(final LocalTime unaHora) {
    boolean _and = false;
    boolean _esMayorHoraInicio = this.esMayorHoraInicio(unaHora);
    if (!_esMayorHoraInicio) {
      _and = false;
    } else {
      boolean _esMenorHoraFin = this.esMenorHoraFin(unaHora);
      _and = _esMenorHoraFin;
    }
    return _and;
  }
  
  public boolean esMayorHoraInicio(final LocalTime unaHora) {
    int _millisOfDay = unaHora.getMillisOfDay();
    int _millisOfDay_1 = this.horaInicio.getMillisOfDay();
    return (_millisOfDay > _millisOfDay_1);
  }
  
  public boolean esMenorHoraFin(final LocalTime unaHora) {
    int _millisOfDay = unaHora.getMillisOfDay();
    int _millisOfDay_1 = this.horaFin.getMillisOfDay();
    return (_millisOfDay < _millisOfDay_1);
  }
}
