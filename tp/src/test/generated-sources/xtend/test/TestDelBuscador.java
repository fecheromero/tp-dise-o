package test;

import dominio.Buscador;
import dominio.CGP;
import dominio.Comuna;
import dominio.Direccion;
import dominio.LibreriaEscolar;
import dominio.ParadaDeColectivo;
import dominio.PuntoDeInteres;
import dominio.Servicio;
import java.util.Collections;
import java.util.HashSet;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@SuppressWarnings("all")
public class TestDelBuscador {
  private Buscador buscador;
  
  private String string1;
  
  private String string2;
  
  private String string3;
  
  private String string4;
  
  private String string5;
  
  private Comuna almagro;
  
  private Comuna lugano;
  
  private CGP unCGP;
  
  private ParadaDeColectivo _114;
  
  private LibreriaEscolar unaLibreria;
  
  private HashSet<PuntoDeInteres> unSorteaditoDePuntos;
  
  @Before
  public void setUp() {
    this.string1 = "muebleria";
    this.string2 = "mueble";
    this.string3 = "sangucheria";
    this.string4 = "embuebido";
    this.string5 = "muebleria don pepito";
    Point _point = new Point(1, 2);
    Point _point_1 = new Point(2, 3);
    Polygon _polygon = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point, _point_1)));
    Comuna _comuna = new Comuna("almagro", _polygon);
    this.almagro = _comuna;
    Point _point_2 = new Point(2, 4);
    Point _point_3 = new Point(4, 5);
    Polygon _polygon_1 = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point_2, _point_3)));
    Comuna _comuna_1 = new Comuna("lugano", _polygon_1);
    this.lugano = _comuna_1;
    Servicio _servicio = new Servicio("asistencia Social");
    Point _point_4 = new Point(4, 6);
    Direccion _direccion = new Direccion("calle sarmiento", "2142", new String[] { "san Martin", "Belgrano" }, _point_4, "bs as", "Buenos Aires", this.almagro, "1881", "", "", "");
    CGP _cGP = new CGP(Collections.<Servicio>unmodifiableList(CollectionLiterals.<Servicio>newArrayList(_servicio)), _direccion, "Centro de gestion y participacion");
    this.unCGP = _cGP;
    Point _point_5 = new Point(1, 2);
    Direccion _direccion_1 = new Direccion("Mozart", "1919", new String[] { "Dellepiane", "Otra calle" }, _point_5, "bs as", "Buenos Aires", this.lugano, "1422", "", "", "");
    ParadaDeColectivo _paradaDeColectivo = new ParadaDeColectivo(_direccion_1, "Parada colectivo 114");
    this._114 = _paradaDeColectivo;
    Point _point_6 = new Point(6, 2);
    Direccion _direccion_2 = new Direccion("calle 848", "2114", new String[] { "893", "892" }, _point_6, "bs as", "Buenos Aires", this.almagro, "1881", "", "", "");
    LibreriaEscolar _libreriaEscolar = new LibreriaEscolar(_direccion_2, "libreria don Pepito");
    this.unaLibreria = _libreriaEscolar;
    HashSet<PuntoDeInteres> _hashSet = new HashSet<PuntoDeInteres>();
    this.unSorteaditoDePuntos = _hashSet;
    this.unSorteaditoDePuntos.addAll(Collections.<PuntoDeInteres>unmodifiableList(CollectionLiterals.<PuntoDeInteres>newArrayList(this.unaLibreria, this._114, this.unCGP)));
    Buscador _buscador = new Buscador();
    this.buscador = _buscador;
    this.buscador.setPuntos(this.unSorteaditoDePuntos);
  }
  
  @Test
  public void laMasParecida() {
    String _seleccionarLaMasParecida = this.buscador.seleccionarLaMasParecida(this.string2, new String[] { this.string1, this.string3, this.string4, this.string5 });
    Assert.assertEquals(_seleccionarLaMasParecida, this.string1);
  }
  
  @Test
  public void pruebaDeSeparadorDePalabras() {
    String[] _separarPalabras = this.buscador.separarPalabras("palabra1 palabra2 palabra3");
    Assert.assertArrayEquals(_separarPalabras, new Object[] { "palabra1", "palabra2", "palabra3" });
  }
  
  @Test
  public void pruebaDeBusquedaLibreriaDonPepitoEnUnSoreaditoDePuntos() {
    PuntoDeInteres[] _pTenDePuntos = this.buscador.topTenDePuntos("libreria don Pepito");
    Iterable<Object> _take = IterableExtensions.<Object>take(((Iterable<Object>)Conversions.doWrapArray(_pTenDePuntos)), 1);
    Assert.assertArrayEquals(((Object[])Conversions.unwrapArray(_take, Object.class)), new Object[] { this.unaLibreria });
  }
  
  @Test
  public void pruebaDeBusquedaParadaDel114() {
    PuntoDeInteres[] _pTenDePuntos = this.buscador.topTenDePuntos("114");
    Iterable<Object> _take = IterableExtensions.<Object>take(((Iterable<Object>)Conversions.doWrapArray(_pTenDePuntos)), 1);
    Assert.assertArrayEquals(((Object[])Conversions.unwrapArray(_take, Object.class)), new Object[] { this._114 });
  }
}
