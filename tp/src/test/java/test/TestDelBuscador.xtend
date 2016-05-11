package test

import dependencias.Buscador
import dominio.locales.LocalComercial
import dominio.pois.PuntoDeInteres
import java.util.HashSet
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.pois.Comuna
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import dominio.pois.ParadaDeColectivo
import dominio.pois.CGP
import fixtures.CGPFixture
import fixtures.ParadaColectivoFixture
import fixtures.LibreriaFixture
import fixtures.KioscoFixture

public class TestDelBuscador {
	Buscador buscador
	String string1
	String string2
	String string3
	String string4
	String string5
	CGP unCGP
	Comuna almagro
	ParadaDeColectivo _114
	LocalComercial unaLibreria
	LocalComercial unKiosco
	HashSet<PuntoDeInteres> unSorteaditoDePuntos
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
		
		string1 = "muebleria"
		string2 = "mueble"
		string3 = "sangucheria"
		string4 = "embuebido"
		string5 = "muebleria don pepito"
		
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		unCGP = cgpFixture.obtenerCGP(almagro)
		
		_114 = paradaFixture.obtenerParadaColectivo
		
		unaLibreria = libreriaFixture.obtenerLibreria
		
		unKiosco = kioscoFixture.obtenerKiosco
		
		unSorteaditoDePuntos = new HashSet<PuntoDeInteres>
		unSorteaditoDePuntos.addAll(#[unaLibreria, _114, unCGP, unKiosco])
		
		buscador = Buscador.getInstance
		buscador.puntos = unSorteaditoDePuntos
		

	}

	@Test
	def void laMasParecida() {
		Assert.assertEquals(buscador.seleccionarLaMasParecida(string2, #[string1, string3, string4, string5]), string1)
	}

	@Test
	def void pruebaDeSeparadorDePalabras() {
		Assert.assertArrayEquals(buscador.separarPalabras("palabra1 palabra2 palabra3"),
			#["palabra1", "palabra2", "palabra3"])

	}

	@Test
	def void pruebaDeBusquedaLibreriaDonPepitoEnUnSoreaditoDePuntos() {
		Assert.assertArrayEquals(buscador.topTenDePuntos("libreria don Pepito").take(1), #[unaLibreria])
	}

	@Test
	def void pruebaDeBusquedaParadaDel114EnUnSorteaditoDePuntos() {
		Assert.assertArrayEquals(buscador.topTenDePuntos("114").take(1), #[_114])

	}

	@Test
	def void pruebaDeBusquedaxRubroKioscoEnUnSorteaditoDePuntos() {
		Assert.assertArrayEquals(buscador.topTenDePuntos("kiosco").take(1), #[unKiosco])
	}



}
