package test

import dominio.CGP
import dominio.Comuna
import dominio.LocalComercial
import dominio.ParadaDeColectivo
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon

public class TestDistancia {
	Point unPunto
	Point otroPunto
	CGP cgp
	Comuna once
	ParadaDeColectivo _114
	LocalComercial unaLibreria
	LocalComercial unKiosco
	CGPFixture cgpFixture
	ParadaColectivoFixture paradaFixture
	LibreriaFixture libreriaFixture
	KioscoFixture kioscoFixture


	@Before
	def void setUp() {
		
		cgpFixture = new CGPFixture
		paradaFixture = new ParadaColectivoFixture
		libreriaFixture = new LibreriaFixture
		kioscoFixture = new KioscoFixture
		
		unPunto = new Point(1, 2)
		otroPunto = new Point(0, 0.9995)
		
		once = new Comuna("once", new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))
		cgp = cgpFixture.obtenerCGP(once)
		

		_114 = paradaFixture.obtenerParadaColectivo
		
		unaLibreria = libreriaFixture.obtenerLibreria

		unKiosco = kioscoFixture.obtenerKiosco

	}

	// 1 unidad en coordenadas geograficas son aproximadamente 110,59 km
	@Test
	def void estaCercaUnCGPAUnPuntoDentroDeSuComuna() {
		Assert.assertTrue(cgp.estaCercaDe(unPunto))
	}

	@Test
	def void noEstaCercaUnCGPAUnPuntoFueraDeSuComuna() {
		Assert.assertFalse(cgp.estaCercaDe(otroPunto))
	}

	@Test
	def void estaCercaUnaParadaDeColectivoDePuntoAMenosDe1Cuadra() {
		Assert.assertTrue(_114.estaCercaDe(otroPunto))
	}

	@Test
	def void NoestaCercaUnaParadaDeColectivoDeUnPuntoAMasDeUnaCuadra() {
		Assert.assertFalse(_114.estaCercaDe(unPunto))
	}

	@Test
	def void NoEstaCercaUnaLibreriaAUnPuntoAMasDe5Cuadras() {
		Assert.assertFalse(unaLibreria.estaCercaDe(unPunto))
	}

	@Test
	def void NoEstaCercaUnKioscoAUnPuntoAMasDe2Cuadras() {
		Assert.assertFalse(unKiosco.estaCercaDe(unPunto))
	}
}
