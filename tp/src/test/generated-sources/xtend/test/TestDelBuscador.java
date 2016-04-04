package test;

import dominio.Buscador;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings("all")
public class TestDelBuscador {
  private Buscador buscador;
  
  private String string1;
  
  private String string2;
  
  private String string3;
  
  private String string4;
  
  private String string5;
  
  @Before
  public void setUp() {
    this.string1 = "muebleria";
    this.string2 = "mueble";
    this.string3 = "sangucheria";
    this.string4 = "embuebido";
    this.string5 = "muebleria don pepito";
    Buscador _buscador = new Buscador();
    this.buscador = _buscador;
  }
  
  @Test
  public void comprarMuebleriaConMueble() {
    String _masParecido = this.buscador.masParecido("muebles en venta", "venta", "mueble");
    Assert.assertEquals(_masParecido, "venta");
  }
  
  @Test
  public void laMasParecida() {
    String _seleccionarLaMasParecida = this.buscador.seleccionarLaMasParecida(this.string2, new String[] { this.string1, this.string3, this.string4, this.string5 });
    Assert.assertEquals(_seleccionarLaMasParecida, this.string1);
  }
}
