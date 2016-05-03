package test

import dominio.CGP
import dominio.ParadaDeColectivo
import dominio.SucursalBanco
import org.joda.time.DateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.LocalComercial

public class TestDisponibilidad {
	SucursalBanco santander
	LocalComercial carrousel
	ParadaDeColectivo linea7
	CGP cgpFlores
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

	}

	@Test // SE LO CAMBIO POR SABADO MAÑANA PARA APROVECHAR LA FECHA DE OTROS TESTS
	def void testDisponibilidadParadaDeColectivoSabadoALaMañana() {
//		var DateTime fecha = new DateTime("2016-04-16T12:30")
		Assert.assertTrue(linea7.estaDisponible(diaSabadoMañana, ""))

	}

	@Test // LISTO
	def void testDisponibilidadParadaDeColectivoJuevesALaMañana() {
//		var DateTime fecha = new DateTime("2016-04-14T11:00")
		Assert.assertTrue(linea7.estaDisponible(diaJuevesMañana, ""))

	}

	@Test // LISTO
	def void testDisponibilidadAlgunServicioAbiertoJuevesEnCgpFlores() {
//		var DateTime fecha = new DateTime("2016-04-14T11:00")
		Assert.assertTrue(cgpFlores.estaDisponible(diaJuevesMañana, ""))

	}

	@Test
	def void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorHoraDeAlmuerzo() {
//		var DateTime fecha = new DateTime("2016-04-15T13:30")
		Assert.assertFalse(cgpFlores.estaDisponible(diaViernesMediodia, ""))

	}

	@Test // LISTO
	def void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorSerDomingo() {
//		var DateTime fecha = new DateTime("2016-04-17T09:30")
		Assert.assertFalse(cgpFlores.estaDisponible(diaDomingoMañana, ""))
	}

	@Test // SE LO CAMBIO POR JUEVES PARA APROVECHAR OTROS HORARIOS
	def void testDisponibilidadServicioRentasAbiertoJuevesCgpFlores() {
//		var DateTime fecha = new DateTime("2016-04-13T17:30")
		Assert.assertTrue(cgpFlores.estaDisponible(diaJuevesMañana, "Rentas"))

	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorHoraCgpFlores() {
//		var DateTime fecha = new DateTime("2016-04-15T13:30")
		Assert.assertFalse(cgpFlores.estaDisponible(diaViernesMediodia, "Registro Civil"))

	}

	@Test // LISTO
	def void testDisponibilidadServicioRegistroCivilCerradoPorSerSabadoCgpFlores() {
//		var DateTime fecha = new DateTime("2016-04-16T12:30")
		Assert.assertFalse(cgpFlores.estaDisponible(diaSabadoMañana, "Registro Civil"))

	}

	@Test
	def void testDisponibilidadSucursalBancoAbierto() {
//		var DateTime fecha = new DateTime("2016-04-15T13:30")
		Assert.assertTrue(santander.estaDisponible(diaViernesMediodia, ""))

	}

	@Test
	def void testDisponibilidadServicioCobranzasDeSucursalBancoFueraDeHorarioBancario() {
//		var DateTime fecha = new DateTime("2016-04-15T15:30")
		Assert.assertFalse(santander.estaDisponible(diaViernesTarde, "Cobranzas"))
	}

	@Test
	def void testDisponibilidadServicioRentasDeSucursalBancoDentroDeHorarioDelServicio() {
//		var DateTime fecha = new DateTime("2016-04-28T14:30")
		Assert.assertTrue(santander.estaDisponible(diaJuevesMañana, "Rentas"))

	}

	@Test
	def void testDisponibilidadServicioRentasDeSucursalBancoFueraDeHorarioDelServicio() {
//		var DateTime fecha = new DateTime("2016-04-27T13:30")
		Assert.assertFalse(santander.estaDisponible(diaViernesMediodia, "Rentas"))

	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorHora() {
//		var DateTime fecha = new DateTime("2016-04-15T15:30")
		Assert.assertFalse(santander.estaDisponible(diaViernesTarde, ""))

	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorDiaDomingo() {
//		var DateTime fecha = new DateTime("2016-04-17T09:30")
		Assert.assertFalse(santander.estaDisponible(diaDomingoMañana, ""))

	}

	@Test // LISTO
	def void testDisponibilidadLocalCarrouselMañanaDiaSabado() {
//		var DateTime fecha = new DateTime("2016-04-16T12:30")
		Assert.assertTrue(carrousel.estaDisponible(diaSabadoMañana, ""))

	}

	@Test
	def void testDisponibilidadLocalCarrouselJuevesMañanaDentroDeHorario() {
//		var DateTime fecha = new DateTime("2016-04-14T11:00")
		Assert.assertTrue(carrousel.estaDisponible(diaJuevesMañana, ""))

	}

	@Test // LISTO
	def void testDisponibilidadLocalCarrouselDiaDomingo() {
//		var DateTime fecha = new DateTime("2016-04-17T09:30")
		Assert.assertFalse(carrousel.estaDisponible(diaDomingoMañana, ""))

	}
}
