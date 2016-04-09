package test;

import dominio.Buscador;
import java.util.Collection;
import java.util.Collections;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
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
  
  @Test
  public void pruebaDeOrdenador() {
    Collection<Integer> _ordenador = this.buscador.ordenador(Collections.<Integer>unmodifiableList(CollectionLiterals.<Integer>newArrayList(Integer.valueOf(3), Integer.valueOf(2), Integer.valueOf(4), Integer.valueOf(1))));
    Assert.assertEquals(_ordenador, Collections.<Integer>unmodifiableList(CollectionLiterals.<Integer>newArrayList(Integer.valueOf(1), Integer.valueOf(2), Integer.valueOf(3), Integer.valueOf(4))));
  }
  
  @Test
  public void pruebaDeSeparadorDePalabras() {
    String[] _separarPalabras = this.buscador.separarPalabras("palabra1 palabra2 palabra3");
    Assert.assertArrayEquals(_separarPalabras, new Object[] { "palabra1", "palabra2", "palabra3" });
  }
}
