package test

import dominio.CGP
//<<<<<<< HEAD
//import dominio.Horario
//import dominio.ParadaDeColectivo
//import dominio.Servicio
//import dominio.SucursalBanco
//import dominio.Turno
//import org.joda.time.DateTime
//import org.joda.time.LocalTime
//import org.junit.Assert
//import org.junit.Before
//import org.junit.Test
//import dominio.Direccion
//import dominio.Comuna
//import org.uqbar.geodds.Point
//import org.uqbar.geodds.Polygon
//import java.util.HashSet
//import dominio.*
//import dominio.Horario.Dia
//=======
import dominio.ParadaDeColectivo
import dominio.SucursalBanco
import org.joda.time.DateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.LocalComercial
//>>>>>>> development

public class TestDisponibilidad {
	SucursalBanco santander
	LocalComercial carrousel
	ParadaDeColectivo linea7
	CGP cgpFlores
//<<<<<<< HEAD
//
//	@Before
//	def void setUp() {
//		var diasHabilesRentas = new HashSet<Dia>
//		diasHabilesRentas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE)
//		var turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(13, 0))
//		var turnoTarde = new Turno(new LocalTime(14, 0), new LocalTime(18, 0))
//		var turnosDisponiblesRentas = new HashSet<Turno>
//		turnosDisponiblesRentas.addAll(turnoMañana, turnoTarde)
//		var horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas)
//
//		var diasHabilesRegistroCivil = new HashSet<Dia>
//		diasHabilesRegistroCivil.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE)
//		var turnoRegistroCivil = new Turno(new LocalTime(7, 0), new LocalTime(12, 30))
//		var turnosDisponiblesRegistroCivil = new HashSet<Turno>
//		turnosDisponiblesRegistroCivil.add(turnoRegistroCivil)
//		var horarioRegistroCivil = new Horario(diasHabilesRegistroCivil, turnosDisponiblesRegistroCivil)
//
//		var diasHabilesCobranzas = new HashSet<Dia>
//		diasHabilesCobranzas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.MIE)
//		var turnoCobranzas = new Turno(new LocalTime(8, 0), new LocalTime(16, 0))
//		var turnosDisponiblesCobranzas = new HashSet<Turno>
//		turnosDisponiblesCobranzas.add(turnoCobranzas)
//		var horarioCobranzas = new Horario(diasHabilesCobranzas, turnosDisponiblesRentas)
//
//		var diasHabilesCarrousel = new HashSet<Dia>
//		diasHabilesCarrousel.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.VIE, Dia.SAB)
//		var turnoMañanaCarrousel = new Turno(new LocalTime(10, 0), new LocalTime(13, 0))
//		var turnoTardeCarrousel = new Turno(new LocalTime(17, 0), new LocalTime(20, 30))
//		var turnosDisponiblesCarrousel = new HashSet<Turno>
//		turnosDisponiblesCarrousel.addAll(turnoMañanaCarrousel, turnoTardeCarrousel)
//		var horarioCarrousel = new Horario(diasHabilesCarrousel, turnosDisponiblesCarrousel)
//		var unRubro = new Rubro("Libreria Comercial", 0.2)
//
//		var almagro = new Comuna("once",
//			new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))
//
//		var direccionBanco = new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as",
//			"Buenos Aires", almagro, "3333", "", "", "")
//		var direccionLinea7 = new Direccion("calle Rivadavia", "7654", #["jorge", "roberto"], new Point(1, 0), "bs as",
//			"Buenos Aires", almagro, "3333", "", "", "")
//
//		var registroCivil = new Servicio("Registro Civil", horarioRegistroCivil)
//		var rentas = new Servicio("Rentas", horarioRentas)
//		var cobranzas = new Servicio("Cobranzas", horarioCobranzas)
//		var serviciosCGP = new HashSet<Servicio>
//		serviciosCGP.addAll(rentas, registroCivil)
//		var serviciosBanco = new HashSet<Servicio>
//		serviciosBanco.addAll(rentas, cobranzas)
//
//		santander = new SucursalBanco(serviciosBanco, direccionBanco, "santander rio 8")
//
//		linea7 = new ParadaDeColectivo(direccionLinea7, "linea 7")
//
//		cgpFlores = new CGP(serviciosCGP, direccionLinea7, "CGP FLORES")
//
//		carrousel = new LocalComercial("Libreria Carrousel", horarioCarrousel, direccionBanco, unRubro)
//=======
	DateTime diaDomingoMañana
	DateTime diaSabadoMañana
	DateTime diaJuevesMañana
	DateTime diaViernesMediodia
	DateTime diaViernesTarde
	SucursalBancoFixture bancoFixture
	ParadaColectivoFixture paradaFixture
	CGPFixture cgpFixture
	LibreriaFixture libreriaFixture

	@Before
	def void setUp() {
		
		bancoFixture = new SucursalBancoFixture
		paradaFixture = new ParadaColectivoFixture
		cgpFixture = new CGPFixture
		libreriaFixture = new LibreriaFixture

		santander = bancoFixture.obtenerBanco

		linea7 = paradaFixture.obtenerParadaColectivo

		cgpFlores = cgpFixture.obtenerCGPFlores

		carrousel = libreriaFixture.obtenerCarroussel
		
		diaDomingoMañana = new DateTime("2016-04-17T09:30")
		
		diaSabadoMañana = new DateTime("2016-04-16T12:30")
		
		diaJuevesMañana = new DateTime("2016-04-14T11:00")
		
		diaViernesMediodia = new DateTime("2016-04-15T13:30")
		
		diaViernesTarde = new DateTime("2016-04-15T15:30")
//>>>>>>> development

	}

	@Test
//<<<<<<< HEAD
//	def void testDisponibilidadParadaDeColectivoSabadoALaNoche() {
//		var DateTime fecha = new DateTime("2016-04-16T23:30")
//		Assert.assertTrue(linea7.estaDisponible(fecha, ""))
//=======
	def void testDisponibilidadParadaDeColectivoSabadoALaMañana() {
		Assert.assertTrue(linea7.estaDisponible(diaSabadoMañana, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadParadaDeColectivoJuevesALaMañana() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-14T09:30")
//		Assert.assertTrue(linea7.estaDisponible(fecha, ""))
//=======
		Assert.assertTrue(linea7.estaDisponible(diaJuevesMañana, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadAlgunServicioAbiertoJuevesEnCgpFlores() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-14T07:30")
//		Assert.assertTrue(cgpFlores.estaDisponible(fecha, ""))
//=======
		Assert.assertTrue(cgpFlores.estaDisponible(diaJuevesMañana, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorHoraDeAlmuerzo() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-14T13:30")
//		Assert.assertFalse(cgpFlores.estaDisponible(fecha, ""))
//=======
		Assert.assertFalse(cgpFlores.estaDisponible(diaViernesMediodia, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorSerDomingo() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-17T09:30")
//		Assert.assertFalse(cgpFlores.estaDisponible(fecha, ""))
//	}
//
//	@Test
//	def void testDisponibilidadServicioRentasAbiertoMiercolesCgpFlores() {
//		var DateTime fecha = new DateTime("2016-04-13T17:30")
//		Assert.assertTrue(cgpFlores.estaDisponible(fecha, "Rentas"))
//=======
		Assert.assertFalse(cgpFlores.estaDisponible(diaDomingoMañana, ""))
	}

	@Test
	def void testDisponibilidadServicioRentasAbiertoJuevesCgpFlores() {
		Assert.assertTrue(cgpFlores.estaDisponible(diaJuevesMañana, "Rentas"))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorHoraCgpFlores() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-12T14:10")
//		Assert.assertFalse(cgpFlores.estaDisponible(fecha, "Registro Civil"))
//=======
		Assert.assertFalse(cgpFlores.estaDisponible(diaViernesMediodia, "Registro Civil"))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorSerSabadoCgpFlores() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-16T10:00")
//		Assert.assertFalse(cgpFlores.estaDisponible(fecha, "Registro Civil"))
//=======
		Assert.assertFalse(cgpFlores.estaDisponible(diaSabadoMañana, "Registro Civil"))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadSucursalBancoAbierto() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-15T13:30")
//		Assert.assertTrue(santander.estaDisponible(fecha, ""))
//=======
		Assert.assertTrue(santander.estaDisponible(diaViernesMediodia, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadServicioCobranzasDeSucursalBancoFueraDeHorarioBancario() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-15T15:30")
//		Assert.assertFalse(santander.estaDisponible(fecha, "Cobranzas"))
//=======
		Assert.assertFalse(santander.estaDisponible(diaViernesTarde, "Cobranzas"))
//>>>>>>> development
	}

	@Test
	def void testDisponibilidadServicioRentasDeSucursalBancoDentroDeHorarioDelServicio() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-28T14:30")
//		Assert.assertTrue(santander.estaDisponible(fecha, "Rentas"))
//=======
		Assert.assertTrue(santander.estaDisponible(diaJuevesMañana, "Rentas"))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadServicioRentasDeSucursalBancoFueraDeHorarioDelServicio() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-27T13:30")
//		Assert.assertFalse(santander.estaDisponible(fecha, "Rentas"))
//=======
		Assert.assertFalse(santander.estaDisponible(diaViernesMediodia, "Rentas"))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorHora() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-15T15:30")
//		Assert.assertFalse(santander.estaDisponible(fecha, ""))
//=======
		Assert.assertFalse(santander.estaDisponible(diaViernesTarde, ""))
//>>>>>>> development

	}

	@Test
//<<<<<<< HEAD
//	def void testDisponibilidadSucursalBancoCerradoPorDia() {
//		var DateTime fecha = new DateTime("2016-04-17T12:30")
//		Assert.assertFalse(santander.estaDisponible(fecha, ""))
//=======
	def void testDisponibilidadSucursalBancoCerradoPorDiaDomingo() {
		Assert.assertFalse(santander.estaDisponible(diaDomingoMañana, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadLocalCarrouselMañanaDiaSabado() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-16T12:30")
//		Assert.assertTrue(carrousel.estaDisponible(fecha, ""))
//=======
		Assert.assertTrue(carrousel.estaDisponible(diaSabadoMañana, ""))
//>>>>>>> development

	}

	@Test
//<<<<<<< HEAD
//	def void testDisponibilidadLocalCarrouselMartesNocheDentroDeHorario() {
//		var DateTime fecha = new DateTime("2016-04-19T20:20")
//		Assert.assertTrue(carrousel.estaDisponible(fecha, ""))
//=======
	def void testDisponibilidadLocalCarrouselJuevesMañanaDentroDeHorario() {
		Assert.assertTrue(carrousel.estaDisponible(diaJuevesMañana, ""))
//>>>>>>> development

	}

	@Test
	def void testDisponibilidadLocalCarrouselDiaDomingo() {
//<<<<<<< HEAD
//		var DateTime fecha = new DateTime("2016-04-17T18:30")
//		Assert.assertFalse(carrousel.estaDisponible(fecha, ""))
//=======
		Assert.assertFalse(carrousel.estaDisponible(diaDomingoMañana, ""))
//>>>>>>> development

	}
}
