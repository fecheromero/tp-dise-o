package test

import dominio.CGP
import dominio.Horario
import dominio.LocalComercial
import dominio.ParadaDeColectivo
import dominio.Servicio
import dominio.SucursalBanco
import dominio.Turno
import java.util.Set
import org.joda.time.DateTime
import org.joda.time.LocalTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.Direccion
import dominio.Comuna
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import java.util.List
import java.util.HashSet
import dominio.LibreriaEscolar

public class TestDisponibilidad {
	SucursalBanco santander
	LibreriaEscolar carrousel
	ParadaDeColectivo linea7
	CGP cgpFlores
	Servicio rentas
	Servicio registroCivil
	Turno turnoMañana
	Turno turnoMañanaCarrousel
	Turno turnoTardeCarrousel
	Turno turnoTarde
	Turno turnoCompleto
	Turno turnoRentas
	Turno turnoRegistroCivil
	Horario horarioCoto
	Horario horarioCarrousel
	Horario horarioRentas
	Horario horarioRegistroCivil
	HashSet<Turno> turnosDisponiblesCoto
	HashSet<Turno> turnosDisponiblesCarrousel
	HashSet<Turno> turnosDisponiblesRentas
	HashSet<Turno> turnosDisponiblesRegistroCivil
	HashSet<Servicio> servicios
	HashSet<Integer> diasHabilesRentas
	HashSet<Integer> diasHabilesCarrousel
	HashSet<Integer> diasHabilesRegistroCivil
	Direccion direccionLinea7
	Direccion direccionBanco
	Comuna almagro

	@Before
	def void setUp() {
		diasHabilesRentas = new HashSet<Integer>
		diasHabilesRentas.addAll(1, 2, 3, 4)
		turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(13, 0))
		turnoTarde = new Turno(new LocalTime(14, 0), new LocalTime(18, 0))
		turnosDisponiblesRentas = new HashSet<Turno>
		turnosDisponiblesRentas.addAll(turnoMañana, turnoTarde)
		horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas)
		//
		diasHabilesRegistroCivil = new HashSet<Integer>
		diasHabilesRegistroCivil.addAll(1, 2, 3, 4)
		turnoRegistroCivil = new Turno(new LocalTime(7, 0), new LocalTime(12, 30))
		turnosDisponiblesRegistroCivil = new HashSet<Turno>
		turnosDisponiblesRegistroCivil.addAll(turnoRegistroCivil)
		horarioRegistroCivil = new Horario(diasHabilesRegistroCivil, turnosDisponiblesRegistroCivil)

		diasHabilesCarrousel = new HashSet<Integer>
		diasHabilesCarrousel.addAll(1, 2, 3, 4, 5, 6)
		turnoMañanaCarrousel = new Turno(new LocalTime(10, 0), new LocalTime(13, 0))
		turnoTardeCarrousel = new Turno(new LocalTime(17, 0), new LocalTime(20, 30))
		turnosDisponiblesCarrousel = new HashSet<Turno>
		turnosDisponiblesCarrousel.addAll(turnoMañanaCarrousel, turnoTardeCarrousel)
		horarioCarrousel = new Horario(diasHabilesCarrousel, turnosDisponiblesCarrousel)

		almagro = new Comuna("once", new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))

		direccionBanco = new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as",
			"Buenos Aires", almagro, "3333", "", "", "")
		direccionLinea7 = new Direccion("calle Rivadavia", "7654", #["jorge", "roberto"], new Point(1, 0), "bs as",
			"Buenos Aires", almagro, "3333", "", "", "")

		registroCivil = new Servicio("Registro Civil", horarioRentas)
		rentas = new Servicio("rentas", horarioRentas)
		servicios = new HashSet<Servicio>
		servicios.add(rentas)
		servicios.add(registroCivil)
		santander = new SucursalBanco(servicios, direccionBanco, "santander rio 8")

		linea7 = new ParadaDeColectivo(direccionLinea7, "linea 7")

		cgpFlores = new CGP(servicios, direccionLinea7, "CGP FLORES")

		carrousel = new LibreriaEscolar("Libreria Carrousel", horarioCarrousel , direccionBanco )
		
	}

	@Test
	def void testDisponibilidadParadaDeColectivoSabadoALaNoche() {
		var DateTime fecha = new DateTime("2016-04-16T23:30")
		Assert.assertEquals(linea7.estaDisponible(fecha), true)
		linea7.elNegocioEstaDisponibleEnUnMomento(fecha)
	}

	@Test
	def void testDisponibilidadParadaDeColectivoJuevesALaMañana() {
		var DateTime fecha = new DateTime("2016-04-14T09:30")
		Assert.assertEquals(linea7.estaDisponible(fecha), true)
		linea7.elNegocioEstaDisponibleEnUnMomento(fecha)
	}

	@Test
	def void testDisponibilidadAlgunServicioAbiertoCgpFlores() {
		var DateTime fecha = new DateTime("2016-04-14T09:30")
		Assert.assertEquals(cgpFlores.estaDisponible(fecha), true)
		cgpFlores.elNegocioEstaDisponibleEnUnMomento(fecha)
	}

	@Test
	def void testDisponibilidadServicioRentasAbiertoCgpFlores() {
		var DateTime fecha = new DateTime("2016-04-13T17:30")
		Assert.assertEquals(cgpFlores.estaDisponible(fecha, "rentas"), true)
		cgpFlores.elNegocioEstaDisponibleEnUnMomento(fecha, "rentas")
	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorHoraCgpFlores() {
		var DateTime fecha = new DateTime("2016-04-12T00:00")
		Assert.assertEquals(cgpFlores.estaDisponible(fecha, "Registro Civil"), false)
		cgpFlores.elNegocioEstaDisponibleEnUnMomento(fecha, "Registro Civil")
	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorDiaCgpFlores() {
		var DateTime fecha = new DateTime("2016-04-17T10:10")
		Assert.assertEquals(cgpFlores.estaDisponible(fecha, "Registro Civil"), false)
		cgpFlores.elNegocioEstaDisponibleEnUnMomento(fecha, "Registro Civil")
	}

	@Test
	def void testDisponibilidadSucursalBancoAbierto() {
		var DateTime fecha = new DateTime("2016-04-12T13:30")
		Assert.assertEquals(santander.estaDisponible(fecha), true)
		santander.elNegocioEstaDisponibleEnUnMomento(fecha)
	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorHora() {
		var DateTime fecha = new DateTime("2016-04-12T18:30")
		Assert.assertEquals(santander.estaDisponible(fecha), false)
		santander.elNegocioEstaDisponibleEnUnMomento(fecha)
	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorDia() {
		var DateTime fecha = new DateTime("2016-04-17T12:30")
		Assert.assertEquals(santander.estaDisponible(fecha), false)
		santander.elNegocioEstaDisponibleEnUnMomento(fecha)
	}

	@Test
	def void testDisponibilidadLocalCarrouselMañanaDiaHabil() {
		var DateTime fecha = new DateTime("2016-04-16T12:30")
		Assert.assertEquals(carrousel.estaDisponible(fecha), true)
		carrousel.elNegocioEstaDisponibleEnUnMomento(fecha)
	}
	@Test
	def void testDisponibilidadLocalCarrouselDomingo() {
		var DateTime fecha = new DateTime("2016-04-17T18:30")
		Assert.assertEquals(carrousel.estaDisponible(fecha), false)
		carrousel.elNegocioEstaDisponibleEnUnMomento(fecha)
	}
}
