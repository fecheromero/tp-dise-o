package dominio;

import dominio.Horario;
import dominio.PuntoDeInteres;
import org.joda.time.DateTime;

@SuppressWarnings("all")
public abstract class LocalComercial extends PuntoDeInteres {
  public boolean estaDisponible(final DateTime unMomento) {
    Horario _horario = this.getHorario();
    return _horario.esHabilElMomento(unMomento);
  }
}
