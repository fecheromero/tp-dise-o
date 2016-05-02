package dominio;

import dominio.CGP;
import dominio.CentroDTO;
import dominio.ServicioDTO;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Transformer {
  private CGP unCGP;
  
  public void transformarCGP(final CentroDTO centro) {
    final int a = (centro.getNumeroComuna()).intValue();
    ArrayList<ServicioDTO> _serviciosDTO = centro.getServiciosDTO();
    final Set<ServicioDTO> set = new HashSet<ServicioDTO>(_serviciosDTO);
  }
  
  @Pure
  public CGP getUnCGP() {
    return this.unCGP;
  }
  
  public void setUnCGP(final CGP unCGP) {
    this.unCGP = unCGP;
  }
}
