package dominio;

import dominio.Buscador;
import dominio.PuntoDeInteres;
import excepciones.NoValidoException;
import java.util.HashSet;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Repositorio {
  private HashSet<PuntoDeInteres> puntos;
  
  private Buscador buscador = new Buscador();
  
  public void create(final PuntoDeInteres unPunto) {
    try {
      unPunto.validate();
      boolean _contains = this.puntos.contains(unPunto);
      if (_contains) {
        throw new NoValidoException("El Punto ya existe");
      } else {
        this.puntos.add(unPunto);
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void update(final PuntoDeInteres unPunto) {
    this.delete(unPunto);
    this.create(unPunto);
  }
  
  public void delete(final PuntoDeInteres unPunto) {
    try {
      boolean _contains = this.puntos.contains(unPunto);
      if (_contains) {
        this.puntos.remove(unPunto);
      } else {
        throw new NoValidoException("El Punto no existe");
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public PuntoDeInteres searchBynd(final int id) {
    return ((PuntoDeInteres[])Conversions.unwrapArray(this.puntos, PuntoDeInteres.class))[id];
  }
  
  public List<PuntoDeInteres> search(final String valor) {
    return (List<PuntoDeInteres>)Conversions.doWrapArray(this.buscador.mostrarPrimeros(valor, this.puntos, 10));
  }
  
  @Pure
  public HashSet<PuntoDeInteres> getPuntos() {
    return this.puntos;
  }
  
  public void setPuntos(final HashSet<PuntoDeInteres> puntos) {
    this.puntos = puntos;
  }
  
  @Pure
  public Buscador getBuscador() {
    return this.buscador;
  }
  
  public void setBuscador(final Buscador buscador) {
    this.buscador = buscador;
  }
}
