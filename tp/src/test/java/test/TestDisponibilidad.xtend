package test

import dominio.CGP
import dominio.ParadaDeColectivo
import dominio.SucursalBanco
import org.joda.time.DateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.locales.LocalComercial

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

	@Test
	def void testDisponibilidadParadaDeColectivoSabadoALaMañana() {
		Assert.assertTrue(linea7.estaDisponible(diaSabadoMañana, ""))

	}

	@Test
	def void testDisponibilidadParadaDeColectivoJuevesALaMañana() {
		Assert.assertTrue(linea7.estaDisponible(diaJuevesMañana, ""))

	}

	@Test
	def void testDisponibilidadAlgunServicioAbiertoJuevesEnCgpFlores() {
		Assert.assertTrue(cgpFlores.estaDisponible(diaJuevesMañana, ""))

	}

	@Test
	def void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorHoraDeAlmuerzo() {
		Assert.assertFalse(cgpFlores.estaDisponible(diaViernesMediodia, ""))

	}

	@Test
	def void testDisponibilidadNoHayServiciosAbiertosCgpFloresPorSerDomingo() {
		Assert.assertFalse(cgpFlores.estaDisponible(diaDomingoMañana, ""))
	}

	@Test
	def void testDisponibilidadServicioRentasAbiertoJuevesCgpFlores() {
		Assert.assertTrue(cgpFlores.estaDisponible(diaJuevesMañana, "Rentas"))

	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorHoraCgpFlores() {
		Assert.assertFalse(cgpFlores.estaDisponible(diaViernesMediodia, "Registro Civil"))

	}

	@Test
	def void testDisponibilidadServicioRegistroCivilCerradoPorSerSabadoCgpFlores() {
		Assert.assertFalse(cgpFlores.estaDisponible(diaSabadoMañana, "Registro Civil"))

	}

	@Test
	def void testDisponibilidadSucursalBancoAbierto() {
		Assert.assertTrue(santander.estaDisponible(diaViernesMediodia, ""))

	}

	@Test
	def void testDisponibilidadServicioCobranzasDeSucursalBancoFueraDeHorarioBancario() {
		Assert.assertFalse(santander.estaDisponible(diaViernesTarde, "Cobranzas"))
	}

	@Test
	def void testDisponibilidadServicioRentasDeSucursalBancoDentroDeHorarioDelServicio() {
		Assert.assertTrue(santander.estaDisponible(diaJuevesMañana, "Rentas"))

	}

	@Test
	def void testDisponibilidadServicioRentasDeSucursalBancoFueraDeHorarioDelServicio() {
		Assert.assertFalse(santander.estaDisponible(diaViernesMediodia, "Rentas"))

	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorHora() {
		Assert.assertFalse(santander.estaDisponible(diaViernesTarde, ""))

	}

	@Test
	def void testDisponibilidadSucursalBancoCerradoPorDiaDomingo() {
		Assert.assertFalse(santander.estaDisponible(diaDomingoMañana, ""))

	}

	@Test
	def void testDisponibilidadLocalCarrouselMañanaDiaSabado() {
		Assert.assertTrue(carrousel.estaDisponible(diaSabadoMañana, ""))

	}

	@Test
	def void testDisponibilidadLocalCarrouselJuevesMañanaDentroDeHorario() {
		Assert.assertTrue(carrousel.estaDisponible(diaJuevesMañana, ""))

	}

	@Test
	def void testDisponibilidadLocalCarrouselDiaDomingo() {
		Assert.assertFalse(carrousel.estaDisponible(diaDomingoMañana, ""))

	}
}
