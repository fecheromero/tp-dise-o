package test;

import dominio.CGP;
import dominio.Comuna;
import dominio.Direccion;
import dominio.Horario;
import dominio.KioscoDiarios;
import dominio.LibreriaEscolar;
import dominio.ParadaDeColectivo;
import dominio.Servicio;
import dominio.Turno;
import java.util.Collections;
import java.util.HashSet;
import org.eclipse.xtext.xbase.lib.CollectionExtensions;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.joda.time.LocalTime;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@SuppressWarnings("all")
public class TestDistancia {
  private Point unPunto;
  
  private Point puntoParadaColectivo;
  
  private Comuna almagro;
  
  private CGP unCGP;
  
  private CGP otroCGP;
  
  private Comuna once;
  
  private ParadaDeColectivo _114;
  
  private LibreriaEscolar unaLibreria;
  
  private KioscoDiarios unKiosco;
  
  private HashSet<Servicio> serviciosCgp1;
  
  private HashSet<Servicio> serviciosCgp2;
  
  private Horario unHorario;
  
  private HashSet<Integer> unosDias;
  
  private HashSet<Turno> unosTurnos;
  
  @Before
  public void setUp() {
    Point _point = new Point(1, 2);
    this.unPunto = _point;
    Point _point_1 = new Point(1, 2);
    this.puntoParadaColectivo = _point_1;
    HashSet<Turno> _hashSet = new HashSet<Turno>();
    this.unosTurnos = _hashSet;
    LocalTime _localTime = new LocalTime(0, 10);
    LocalTime _localTime_1 = new LocalTime(2, 4);
    Turno _turno = new Turno(_localTime, _localTime_1);
    this.unosTurnos.add(_turno);
    HashSet<Integer> _hashSet_1 = new HashSet<Integer>();
    this.unosDias = _hashSet_1;
    this.unosDias.add(Integer.valueOf(1));
    Horario _horario = new Horario(this.unosDias, this.unosTurnos);
    this.unHorario = _horario;
    HashSet<Servicio> _hashSet_2 = new HashSet<Servicio>();
    this.serviciosCgp1 = _hashSet_2;
    Servicio _servicio = new Servicio("asistencia Social", this.unHorario);
    Servicio _servicio_1 = new Servicio("asistencia Comunitaria", this.unHorario);
    CollectionExtensions.<Servicio>addAll(this.serviciosCgp1, _servicio, _servicio_1);
    HashSet<Servicio> _hashSet_3 = new HashSet<Servicio>();
    this.serviciosCgp2 = _hashSet_3;
    Servicio _servicio_2 = new Servicio("asistencia Social", this.unHorario);
    Servicio _servicio_3 = new Servicio("asistencia Jurídica", this.unHorario);
    Servicio _servicio_4 = new Servicio("Registro Civil", this.unHorario);
    CollectionExtensions.<Servicio>addAll(this.serviciosCgp2, _servicio_2, _servicio_3, _servicio_4);
    Point _point_2 = new Point(1, 2);
    Point _point_3 = new Point(2, 3);
    Polygon _polygon = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point_2, _point_3)));
    Comuna _comuna = new Comuna("almagro", _polygon);
    this.almagro = _comuna;
    Point _point_4 = new Point(0, 0);
    Point _point_5 = new Point(0, 5);
    Point _point_6 = new Point(5, 5);
    Point _point_7 = new Point(5, 0);
    Polygon _polygon_1 = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point_4, _point_5, _point_6, _point_7)));
    Comuna _comuna_1 = new Comuna("once", _polygon_1);
    this.once = _comuna_1;
    Point _point_8 = new Point(4, 6);
    Direccion _direccion = new Direccion("calle sarmiento", "2142", new String[] { "san Martin", "Belgrano" }, _point_8, "bs as", 
      "Buenos Aires", this.almagro, "1881", "", "", "");
    CGP _cGP = new CGP(this.serviciosCgp1, _direccion, "Centro de gestion y participacion");
    this.unCGP = _cGP;
    Point _point_9 = new Point(1, 2);
    Direccion _direccion_1 = new Direccion("calle nogoya", "2156", new String[] { "san Martin", "Uquiza" }, _point_9, "bs as", "Buenos Aires", 
      this.once, "1881", "", "", "");
    CGP _cGP_1 = new CGP(this.serviciosCgp2, _direccion_1, "Centro de gestion y participacion");
    this.otroCGP = _cGP_1;
    Point _point_10 = new Point(0, 1);
    Direccion _direccion_2 = new Direccion("Mozart", "1919", new String[] { "Dellepiane", "Otra calle" }, _point_10, "bs as", "Buenos Aires", 
      this.almagro, "1422", "", "", "");
    ParadaDeColectivo _paradaDeColectivo = new ParadaDeColectivo(_direccion_2, "Parada colectivo 114");
    this._114 = _paradaDeColectivo;
    Point _point_11 = new Point(6, 2);
    Direccion _direccion_3 = new Direccion("calle 848", "2114", new String[] { "893", "892" }, _point_11, "bs as", "Buenos Aires", this.almagro, 
      "1881", "", "", "");
    LibreriaEscolar _libreriaEscolar = new LibreriaEscolar("libreria don Pepito", this.unHorario, _direccion_3);
    this.unaLibreria = _libreriaEscolar;
    Point _point_12 = new Point(1, 0);
    Direccion _direccion_4 = new Direccion("calle pepe", "3333", new String[] { "jorge", "roberto" }, _point_12, "bs as", "Buenos Aires", 
      this.almagro, "3333", "", "", "");
    KioscoDiarios _kioscoDiarios = new KioscoDiarios("El Kiosquito", this.unHorario, _direccion_4);
    this.unKiosco = _kioscoDiarios;
  }
  
  @Test
  public void estaCercaDeUnCGPAUnPuntoFueraDeSuComuna() {
    boolean _estaCercaDe = this.unCGP.estaCercaDe(this.unPunto);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(false));
  }
  
  @Test
  public void estaCercaUnCGPAUnPuntoDentroDeSuComuna() {
    boolean _estaCercaDe = this.otroCGP.estaCercaDe(this.unPunto);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(true));
  }
  
  @Test
  public void estaCercaUnaParadaDeColectivoDePuntoAMenosDe1Cuadra() {
    Point _point = new Point(0, 1.0005);
    boolean _estaCercaDe = this._114.estaCercaDe(_point);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(true));
  }
  
  @Test
  public void NoestaCercaUnaParadaDeColectivoDeUnPuntoAMasDeUnaCuadra() {
    Point _point = new Point(0, 1.0014);
    boolean _estaCercaDe = this._114.estaCercaDe(_point);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(false));
  }
  
  @Test
  public void NoEstaCercaUnaLibreriaAUnPuntoAMasDe5Cuadras() {
    Point _point = new Point(6, 2.013);
    boolean _estaCercaDe = this.unaLibreria.estaCercaDe(_point);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(false));
  }
  
  @Test
  public void NoEstaCercaUnKioscoAUnPuntoAMasDe2Cuadras() {
    Point _point = new Point(1, 0.0019);
    boolean _estaCercaDe = this.unKiosco.estaCercaDe(_point);
    Assert.assertEquals(Boolean.valueOf(_estaCercaDe), Boolean.valueOf(false));
  }
}
