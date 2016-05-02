package test;

import dominio.CGP;
import dominio.Comuna;
import dominio.Direccion;
import dominio.Horario;
import dominio.LocalComercial;
import dominio.ParadaDeColectivo;
import dominio.Rubro;
import dominio.Servicio;
import dominio.SucursalBanco;
import dominio.Turno;
import java.util.Collections;
import java.util.HashSet;
import org.eclipse.xtext.xbase.lib.CollectionExtensions;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.joda.time.DateTime;
import org.joda.time.LocalTime;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.uqbar.geodds.Point;
import org.uqbar.geodds.Polygon;

@SuppressWarnings("all")
public class TestDisponibilidad {
  private SucursalBanco santander;
  
  private LocalComercial carrousel;
  
  private ParadaDeColectivo linea7;
  
  private CGP cgpFlores;
  
  @Before
  public void setUp() {
    HashSet<Horario.Dia> diasHabilesRentas = new HashSet<Horario.Dia>();
    CollectionExtensions.<Horario.Dia>addAll(diasHabilesRentas, Horario.Dia.LUN, Horario.Dia.MAR, Horario.Dia.MIE, Horario.Dia.JUE);
    LocalTime _localTime = new LocalTime(9, 0);
    LocalTime _localTime_1 = new LocalTime(13, 0);
    Turno turnoMañana = new Turno(_localTime, _localTime_1);
    LocalTime _localTime_2 = new LocalTime(14, 0);
    LocalTime _localTime_3 = new LocalTime(18, 0);
    Turno turnoTarde = new Turno(_localTime_2, _localTime_3);
    HashSet<Turno> turnosDisponiblesRentas = new HashSet<Turno>();
    CollectionExtensions.<Turno>addAll(turnosDisponiblesRentas, turnoMañana, turnoTarde);
    Horario horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas);
    HashSet<Horario.Dia> diasHabilesRegistroCivil = new HashSet<Horario.Dia>();
    CollectionExtensions.<Horario.Dia>addAll(diasHabilesRegistroCivil, Horario.Dia.LUN, Horario.Dia.MAR, Horario.Dia.MIE, Horario.Dia.JUE);
    LocalTime _localTime_4 = new LocalTime(7, 0);
    LocalTime _localTime_5 = new LocalTime(12, 30);
    Turno turnoRegistroCivil = new Turno(_localTime_4, _localTime_5);
    HashSet<Turno> turnosDisponiblesRegistroCivil = new HashSet<Turno>();
    turnosDisponiblesRegistroCivil.add(turnoRegistroCivil);
    Horario horarioRegistroCivil = new Horario(diasHabilesRegistroCivil, turnosDisponiblesRegistroCivil);
    HashSet<Horario.Dia> diasHabilesCobranzas = new HashSet<Horario.Dia>();
    CollectionExtensions.<Horario.Dia>addAll(diasHabilesCobranzas, Horario.Dia.LUN, Horario.Dia.MAR, Horario.Dia.MIE, Horario.Dia.JUE, Horario.Dia.MIE);
    LocalTime _localTime_6 = new LocalTime(8, 0);
    LocalTime _localTime_7 = new LocalTime(16, 0);
    Turno turnoCobranzas = new Turno(_localTime_6, _localTime_7);
    HashSet<Turno> turnosDisponiblesCobranzas = new HashSet<Turno>();
    turnosDisponiblesCobranzas.add(turnoCobranzas);
    Horario horarioCobranzas = new Horario(diasHabilesCobranzas, turnosDisponiblesRentas);
    HashSet<Horario.Dia> diasHabilesCarrousel = new HashSet<Horario.Dia>();
    CollectionExtensions.<Horario.Dia>addAll(diasHabilesCarrousel, Horario.Dia.LUN, Horario.Dia.MAR, Horario.Dia.MIE, Horario.Dia.JUE, Horario.Dia.VIE, Horario.Dia.SAB);
    LocalTime _localTime_8 = new LocalTime(10, 0);
    LocalTime _localTime_9 = new LocalTime(13, 0);
    Turno turnoMañanaCarrousel = new Turno(_localTime_8, _localTime_9);
    LocalTime _localTime_10 = new LocalTime(17, 0);
    LocalTime _localTime_11 = new LocalTime(20, 30);
    Turno turnoTardeCarrousel = new Turno(_localTime_10, _localTime_11);
    HashSet<Turno> turnosDisponiblesCarrousel = new HashSet<Turno>();
    CollectionExtensions.<Turno>addAll(turnosDisponiblesCarrousel, turnoMañanaCarrousel, turnoTardeCarrousel);
    Horario horarioCarrousel = new Horario(diasHabilesCarrousel, turnosDisponiblesCarrousel);
    Rubro unRubro = new Rubro("Libreria Comercial", Double.valueOf(0.2));
    Point _point = new Point(0, 0);
    Point _point_1 = new Point(0, 5);
    Point _point_2 = new Point(5, 5);
    Point _point_3 = new Point(5, 0);
    Polygon _polygon = new Polygon(Collections.<Point>unmodifiableList(CollectionLiterals.<Point>newArrayList(_point, _point_1, _point_2, _point_3)));
    Comuna almagro = new Comuna("once", _polygon);
    Point _point_4 = new Point(1, 0);
    Direccion direccionBanco = new Direccion("calle pepe", "3333", new String[] { "jorge", "roberto" }, _point_4, "bs as", 
      "Buenos Aires", almagro, "3333", "", "", "");
    Point _point_5 = new Point(1, 0);
    Direccion direccionLinea7 = new Direccion("calle Rivadavia", "7654", new String[] { "jorge", "roberto" }, _point_5, "bs as", 
      "Buenos Aires", almagro, "3333", "", "", "");
    Servicio registroCivil = new Servicio("Registro Civil", horarioRegistroCivil);
    Servicio rentas = new Servicio("Rentas", horarioRentas);
    Servicio cobranzas = new Servicio("Cobranzas", horarioCobranzas);
    HashSet<Servicio> serviciosCGP = new HashSet<Servicio>();
    CollectionExtensions.<Servicio>addAll(serviciosCGP, rentas, registroCivil);
    HashSet<Servicio> serviciosBanco = new HashSet<Servicio>();
    CollectionExtensions.<Servicio>addAll(serviciosBanco, rentas, cobranzas);
    SucursalBanco _sucursalBanco = new SucursalBanco(serviciosBanco, direccionBanco, "santander rio 8");
    this.santander = _sucursalBanco;
    ParadaDeColectivo _paradaDeColectivo = new ParadaDeColectivo(direccionLinea7, "linea 7");
    this.linea7 = _paradaDeColectivo;
    CGP _cGP = new CGP(serviciosCGP, direccionLinea7, "CGP FLORES");
    this.cgpFlores = _cGP;
    LocalComercial _localComercial = new LocalComercial("Libreria Carrousel", horarioCarrousel, direccionBanco, unRubro);
    this.carrousel = _localComercial;
  }
  
  @Test
  public void testDisponibilidadParadaDeColectivoSabadoALaNoche() {
    DateTime fecha = new DateTime("2016-04-16T23:30");
    boolean _estaDisponible = this.linea7.estaDisponible(fecha, "");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadParadaDeColectivoJuevesALaMañana() {
    DateTime fecha = new DateTime("2016-04-14T09:30");
    boolean _estaDisponible = this.linea7.estaDisponible(fecha, "");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadAlgunServicioAbiertoJuevesEnCgpFlores() {
    DateTime fecha = new DateTime("2016-04-14T07:30");
    boolean _estaDisponible = this.cgpFlores.estaDisponible(fecha, "");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorHoraDeAlmuerzo() {
    DateTime fecha = new DateTime("2016-04-14T13:30");
    boolean _estaDisponible = this.cgpFlores.estaDisponible(fecha, "");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorSerDomingo() {
    DateTime fecha = new DateTime("2016-04-17T09:30");
    boolean _estaDisponible = this.cgpFlores.estaDisponible(fecha, "");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadServicioRentasAbiertoMiercolesCgpFlores() {
    DateTime fecha = new DateTime("2016-04-13T17:30");
    boolean _estaDisponible = this.cgpFlores.estaDisponible(fecha, "Rentas");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadServicioRegistroCivilCerradoPorHoraCgpFlores() {
    DateTime fecha = new DateTime("2016-04-12T14:10");
    boolean _estaDisponible = this.cgpFlores.estaDisponible(fecha, "Registro Civil");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadServicioRegistroCivilCerradoPorSerSabadoCgpFlores() {
    DateTime fecha = new DateTime("2016-04-16T10:00");
    boolean _estaDisponible = this.cgpFlores.estaDisponible(fecha, "Registro Civil");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadSucursalBancoAbierto() {
    DateTime fecha = new DateTime("2016-04-15T13:30");
    boolean _estaDisponible = this.santander.estaDisponible(fecha, "");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadServicioCobranzasDeSucursalBancoFueraDeHorarioBancario() {
    DateTime fecha = new DateTime("2016-04-15T15:30");
    boolean _estaDisponible = this.santander.estaDisponible(fecha, "Cobranzas");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadServicioRentasDeSucursalBancoDentroDeHorarioDelServicio() {
    DateTime fecha = new DateTime("2016-04-28T14:30");
    boolean _estaDisponible = this.santander.estaDisponible(fecha, "Rentas");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadServicioRentasDeSucursalBancoFueraDeHorarioDelServicio() {
    DateTime fecha = new DateTime("2016-04-27T13:30");
    boolean _estaDisponible = this.santander.estaDisponible(fecha, "Rentas");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadSucursalBancoCerradoPorHora() {
    DateTime fecha = new DateTime("2016-04-15T15:30");
    boolean _estaDisponible = this.santander.estaDisponible(fecha, "");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadSucursalBancoCerradoPorDia() {
    DateTime fecha = new DateTime("2016-04-17T12:30");
    boolean _estaDisponible = this.santander.estaDisponible(fecha, "");
    Assert.assertFalse(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadLocalCarrouselMañanaDiaSabado() {
    DateTime fecha = new DateTime("2016-04-16T12:30");
    boolean _estaDisponible = this.carrousel.estaDisponible(fecha, "");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadLocalCarrouselMartesNocheDentroDeHorario() {
    DateTime fecha = new DateTime("2016-04-19T20:20");
    boolean _estaDisponible = this.carrousel.estaDisponible(fecha, "");
    Assert.assertTrue(_estaDisponible);
  }
  
  @Test
  public void testDisponibilidadLocalCarrouselDiaDomingo() {
    DateTime fecha = new DateTime("2016-04-17T18:30");
    boolean _estaDisponible = this.carrousel.estaDisponible(fecha, "");
    Assert.assertFalse(_estaDisponible);
  }
}
