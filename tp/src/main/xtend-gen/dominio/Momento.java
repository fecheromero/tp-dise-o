package dominio;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;
import org.joda.time.LocalDate;

@Accessors
@SuppressWarnings("all")
public class Momento {
  private LocalDate fecha;
  
  private int hora;
  
  private int minuto;
  
  private int segundos;
  
  @Pure
  public LocalDate getFecha() {
    return this.fecha;
  }
  
  public void setFecha(final LocalDate fecha) {
    this.fecha = fecha;
  }
  
  @Pure
  public int getHora() {
    return this.hora;
  }
  
  public void setHora(final int hora) {
    this.hora = hora;
  }
  
  @Pure
  public int getMinuto() {
    return this.minuto;
  }
  
  public void setMinuto(final int minuto) {
    this.minuto = minuto;
  }
  
  @Pure
  public int getSegundos() {
    return this.segundos;
  }
  
  public void setSegundos(final int segundos) {
    this.segundos = segundos;
  }
}
