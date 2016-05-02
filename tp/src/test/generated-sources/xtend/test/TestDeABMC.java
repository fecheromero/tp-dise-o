package test;

import dominio.Buscador;
import dominio.CGP;
import dominio.Comuna;
import dominio.Direccion;
import dominio.Horario;
import dominio.LocalComercial;
import dominio.ParadaDeColectivo;
import dominio.PuntoDeInteres;
import dominio.Repositorio;
import dominio.Rubro;
import dominio.Servicio;
import dominio.Turno;
import excepciones.NoValidoException;
import java.util.Collections;
import java.util.HashSet;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.joda.time.LocalTime;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@SuppressWarnings("all")
public class TestDeABMC {
  private Buscador buscador;
  
  private ParadaDeColectivo _114;
  
  private LocalComercial unaLibreria;
  
  private LocalComercial unKiosco;
  
  private HashSet<PuntoDeInteres> unSorteaditoDePuntos;
  
  private HashSet<Servicio> servicios;
  
  private Horario unHorario;
  
  private HashSet<Horario.Dia> unosDias;
  
  private HashSet<Turno> unosTurnos;
  
  private Comuna almagro;
  
  private Comuna lugano;
  
  private CGP unCGP;
  
  private Repositorio repo;
  
  @Before
  public void setUp() {
    Repositorio _repositorio = new Repositorio();
    this.repo = _repositorio;
    HashSet<PuntoDeInteres> _hashSet = new HashSet<PuntoDeInteres>();
    this.repo.setPuntos(_hashSet);
    Buscador _buscador = new Buscador();
    this.buscador = _buscador;
    this.repo.setBuscador(this.buscador);
    HashSet<Turno> _hashSet_1 = new HashSet<Turno>();
    this.unosTurnos = _hashSet_1;
    LocalTime _localTime = new LocalTime(0, 10);
    LocalTime _localTime_1 = new LocalTime(2, 4);
    Turno _turno = new Turno(_localTime, _localTime_1);
    this.unosTurnos.add(_turno);
    HashSet<Horario.Dia> _hashSet_2 = new HashSet<Horario.Dia>();
    this.unosDias = _hashSet_2;
    this.unosDias.add(Horario.Dia.LUN);
    Horario _horario = new Horario(this.unosDias, this.unosTurnos);
    this.unHorario = _horario;
    HashSet<Servicio> _hashSet_3 = new HashSet<Servicio>();
    this.servicios = _hashSet_3;
    Servicio _servicio = new Servicio("asistencia Social", this.unHorario);
    this.servicios.add(_servicio);
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
    Point _point_4 = new Point(4, 6);
    Direccion _direccion = new Direccion("calle sarmiento", "2142", new String[] { "san Martin", "Belgrano" }, _point_4, "bs as", "Buenos Aires", this.almagro, "1881", "", "", "");
    CGP _cGP = new CGP(this.servicios, _direccion, "Centro de gestion y participacion");
    this.unCGP = _cGP;
    Point _point_5 = new Point(1, 2);
    Direccion _direccion_1 = new Direccion("Mozart", "1919", new String[] { "Dellepiane", "Otra calle" }, _point_5, "bs as", "Buenos Aires", 
      this.lugano, "1422", "", "", "");
    ParadaDeColectivo _paradaDeColectivo = new ParadaDeColectivo(_direccion_1, "Parada colectivo 114");
    this._114 = _paradaDeColectivo;
    Point _point_6 = new Point(6, 2);
    Direccion _direccion_2 = new Direccion("calle 848", "2114", new String[] { "893", "892" }, _point_6, "bs as", "Buenos Aires", this.almagro, 
      "1881", "", "", "");
    Rubro _rubro = new Rubro("Libreria Comercial", Double.valueOf(0.5));
    LocalComercial _localComercial = new LocalComercial("libreria don Pepito", this.unHorario, _direccion_2, _rubro);
    this.unaLibreria = _localComercial;
    Point _point_7 = new Point(1, 0);
    Direccion _direccion_3 = new Direccion("calle pepe", "3333", new String[] { "jorge", "roberto" }, _point_7, "bs as", "Buenos Aires", 
      this.almagro, "3333", "", "", "");
    Rubro _rubro_1 = new Rubro("Kiosko de Diarios", Double.valueOf(0.2));
    LocalComercial _localComercial_1 = new LocalComercial("lo de tucu", this.unHorario, _direccion_3, _rubro_1);
    this.unKiosco = _localComercial_1;
  }
  
  @Test(expected = NoValidoException.class)
  public void pruebaDeExcepcionDeUnPuntoConUnCampoEnNull() {
    Rubro _rubro = new Rubro("Kiosko de Diarios", Double.valueOf(0.2));
    final LocalComercial punto = new LocalComercial("elKiosquito", this.unHorario, null, _rubro);
    punto.validate();
  }
  
  @Test(expected = NoValidoException.class)
  public void pruebaDeExcepcionesDeUnPuntoCompletoCuyaDireccionTieneUnCampoNull() {
    Point _point = new Point(1, 0);
    Direccion _direccion = new Direccion(null, "3333", null, _point, "bs as", "Buenos Aires", 
      this.almagro, "3333", "", "", "");
    Rubro _rubro = new Rubro("Kiosco de Diarios", Double.valueOf(0.2));
    final LocalComercial punto = new LocalComercial("elKiosquito", this.unHorario, _direccion, _rubro);
    punto.validate();
  }
  
  @Test
  public void testDeCreacionDePuntos() {
    this.repo.create(this._114);
    HashSet<PuntoDeInteres> _puntos = this.repo.getPuntos();
    int _size = _puntos.size();
    Assert.assertEquals(_size, 1);
  }
  
  @Test(expected = NoValidoException.class)
  public void TestCreacionTiraErrorConUnPuntoIncompleto() {
    this.unaLibreria.setNombre(null);
    this.repo.create(this.unaLibreria);
  }
  
  @Test(expected = NoValidoException.class)
  public void NoSePuedeAgregarUnPuntoYaExistente() {
    this.repo.create(this._114);
    this.repo.create(this._114);
  }
  
  @Test
  public void TesteliminacionDeUnPunto() {
    this.repo.create(this._114);
    HashSet<PuntoDeInteres> _puntos = this.repo.getPuntos();
    int _size = _puntos.size();
    Assert.assertEquals(_size, 1);
    this.repo.delete(this._114);
    HashSet<PuntoDeInteres> _puntos_1 = this.repo.getPuntos();
    int _size_1 = _puntos_1.size();
    Assert.assertEquals(_size_1, 0);
  }
  
  @Test(expected = NoValidoException.class)
  public void TesteliminacionDeUnPuntoQueNoExisteTiraExcepcion() {
    this.repo.delete(this._114);
  }
  
  @Test
  public void TestUpdateDeUnPunto() {
    this.repo.create(this._114);
    this._114.setNombre("nombreDeBondi");
    this.repo.update(this._114);
    HashSet<PuntoDeInteres> _puntos = this.repo.getPuntos();
    PuntoDeInteres _get = ((PuntoDeInteres[])Conversions.unwrapArray(_puntos, PuntoDeInteres.class))[0];
    String _nombre = _get.getNombre();
    Assert.assertEquals(_nombre, "nombreDeBondi");
  }
  
  @Test(expected = NoValidoException.class)
  public void TestUpdateIntentaUpdatearUnPuntoQueNoExiste() {
    this.repo.update(this._114);
  }
  
  @Test
  public void TestBuscarPorId() {
    this.repo.create(this._114);
    this.repo.create(this.unaLibreria);
    PuntoDeInteres _searchBynd = this.repo.searchBynd(0);
    Assert.assertEquals(_searchBynd, this._114);
    PuntoDeInteres _searchBynd_1 = this.repo.searchBynd(1);
    Assert.assertEquals(_searchBynd_1, this.unaLibreria);
  }
}
