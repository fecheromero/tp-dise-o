package dominio;

import dominio.Momento;
import java.util.List;

@SuppressWarnings("all")
public abstract class Horario {
  private List<String> diasHabilesPoi;
  
  public abstract boolean estaAbierto();
  
  public void setearDiasHabiles(final List<String> diasHabiles) {
    this.diasHabilesPoi = diasHabiles;
  }
  
  public abstract boolean esHabilElMomento(final Momento unMomento);
}
