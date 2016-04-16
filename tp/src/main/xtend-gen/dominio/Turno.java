package dominio;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.joda.time.LocalTime;

@Accessors
@SuppressWarnings("all")
public class Turno {
  private LocalTime horaInicio;
  
  private LocalTime horaFin;
  
  public Turno(final LocalTime _horaInicio, final LocalTime _horaFin) {
    this.horaInicio = _horaInicio;
    this.horaFin = _horaFin;
  }
  
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
  
  @Pure
  public LocalTime getHoraInicio() {
    return this.horaInicio;
  }
  
  public void setHoraInicio(final LocalTime horaInicio) {
    this.horaInicio = horaInicio;
  }
  
  @Pure
  public LocalTime getHoraFin() {
    return this.horaFin;
  }
  
  public void setHoraFin(final LocalTime horaFin) {
    this.horaFin = horaFin;
  }
}
