package test;

import dominio.CGP;
import dominio.Comuna;
import dominio.Direccion;
import dominio.ParadaDeColectivo;
import dominio.Servicio;
import java.util.Collections;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@SuppressWarnings("all")
public class TestDistancia {
  private Point unPunto;
  
  private Point puntoParadaColectivo;
  
  private ParadaDeColectivo parada1;
  
  private Comuna almagro;
  
  private CGP unCGP;
  
  private CGP otroCGP;
  
  private Comuna once;
  
  @Before
  public void setUp() {
    Point _point = new Point(1, 2);
    this.unPunto = _point;
    Point _point_1 = new Point(1, 2);
    this.puntoParadaColectivo = _point_1;
    Point _point_2 = new Point(1, 2);
    Point _point_3 = new Point(2, 3);
    Polygon _polygon = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point_2, _point_3)));
    Comuna _comuna = new Comuna("almagro", _polygon);
    this.almagro = _comuna;
    Point _point_4 = new Point(5, 6);
    Point _point_5 = new Point(6, 7);
    Polygon _polygon_1 = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point_4, _point_5)));
    Comuna _comuna_1 = new Comuna("once", _polygon_1);
    this.once = _comuna_1;
    Servicio _servicio = new Servicio("asistencia Social");
    Point _point_6 = new Point(4, 6);
    Direccion _direccion = new Direccion("calle sarmiento", "2142", new String[] { "san Martin", "Belgrano" }, _point_6, "bs as", "Buenos Aires", this.almagro, "1881", "", "", "");
    CGP _cGP = new CGP(Collections.<Servicio>unmodifiableList(CollectionLiterals.<Servicio>newArrayList(_servicio)), _direccion, "Centro de gestion y participacion");
    this.unCGP = _cGP;
    Servicio _servicio_1 = new Servicio("asistencia Comunitaria");
    Point _point_7 = new Point(1, 2);
    Direccion _direccion_1 = new Direccion("calle nogoya", "2156", new String[] { "san Martin", "Uquiza" }, _point_7, "bs as", "Buenos Aires", this.once, "1881", "", "", "");
    CGP _cGP_1 = new CGP(Collections.<Servicio>unmodifiableList(CollectionLiterals.<Servicio>newArrayList(_servicio_1)), _direccion_1, "Centro de gestion y participacion");
    this.otroCGP = _cGP_1;
  }
  
  @Test
  public void estaCercaDe() {
    boolean _estaCercaDe = this.unCGP.estaCercaDe(this.unPunto);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(false));
  }
  
  @Test
  public void estaCerca() {
    boolean _estaCercaDe = this.otroCGP.estaCercaDe(this.unPunto);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(false));
  }
}
