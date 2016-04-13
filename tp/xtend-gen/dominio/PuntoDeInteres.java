package dominio;

import dominio.Direccion;

public abstract class PuntoDeInteres {
  private Direccion direccion;
  
  private /* String */Object nombre;
  
  private static double FACTOR_CONVERSION = 0.001;
  
  private static double DISTANCIA_MAXIMA = 500;
  
  public boolean estaCercaDe(final /* Point */Object coordenadasDestino) {
    return this.verificarCercania(this, coordenadasDestino, PuntoDeInteres.DISTANCIA_MAXIMA);
  }
  
  public boolean verificarCercania(final PuntoDeInteres unPunto, final /* Point */Object coordenadasDestino, final double distanciaMaxima) {
    throw new Error("Unresolved compilation problems:"
      + "\n* cannot be resolved."
      + "\ndistance cannot be resolved"
      + "\n< cannot be resolved");
  }
  
  public Direccion getDireccion() {
    return this.direccion;
  }
}
