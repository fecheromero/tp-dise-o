package dominio;

import dominio.Comuna;

public class Direccion {
  private /* String */Object callePrincipal;
  
  private /* String */Object numero;
  
  private Object/* type is 'null' */ entre;
  
  private /* Point */Object coordenadas;
  
  private /* String */Object localidad;
  
  private /* String */Object provincia;
  
  private Comuna comuna;
  
  private /* String */Object codigoPostal;
  
  private /* String */Object piso;
  
  private /* String */Object departamento;
  
  private /* String */Object unidad;
  
  public /* Point */Object getCoordenadas() {
    return this.coordenadas;
  }
  
  public Comuna getComuna() {
    return this.comuna;
  }
}
