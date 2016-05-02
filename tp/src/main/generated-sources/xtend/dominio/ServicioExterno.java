package dominio;

import dominio.CentroDTO;
import java.util.List;

@SuppressWarnings("all")
public interface ServicioExterno {
  public abstract List<CentroDTO> buscar(final String zona);
}
