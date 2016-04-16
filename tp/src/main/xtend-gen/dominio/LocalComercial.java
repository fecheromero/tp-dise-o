package dominio;

import dominio.PuntoDeInteres;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public abstract class LocalComercial extends PuntoDeInteres {
  private String rubro;
  
  public String listaDeTags() {
    String _listaDeTags = super.listaDeTags();
    String _concat = " ".concat(this.rubro);
    return _listaDeTags.concat(_concat);
  }
  
  @Pure
  public String getRubro() {
    return this.rubro;
  }
  
  public void setRubro(final String rubro) {
    this.rubro = rubro;
  }
}
