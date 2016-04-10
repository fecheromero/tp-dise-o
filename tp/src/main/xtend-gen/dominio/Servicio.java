package dominio;

@SuppressWarnings("all")
public class Servicio {
  private String nombre;
  
  public Servicio(final String _nombre) {
    this.nombre = _nombre;
  }
  
  public String listaDeTags() {
    String _xblockexpression = null;
    {
      String lista = null;
      _xblockexpression = lista = this.nombre;
    }
    return _xblockexpression;
  }
}
