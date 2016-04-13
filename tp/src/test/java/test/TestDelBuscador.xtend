package test

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.*
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import java.util.List
import java.util.Set
import java.util.TreeSet
import java.util.HashSet

public class TestDelBuscador {
	Buscador buscador
	String string1
	String string2
	String string3

	String string4
	String string5
	Comuna almagro
	Comuna lugano
	CGP unCGP
	ParadaDeColectivo _114
	LibreriaEscolar unaLibreria
	KioscoDiarios unKiosco
	HashSet<PuntoDeInteres> unSorteaditoDePuntos
	HashSet<Servicio> servicios

	@Before
	def void setUp() {
		string1 = "muebleria"
		string2 = "mueble"
		string3 = "sangucheria"
		string4 = "embuebido"
		string5 = "muebleria don pepito"
		servicios = new HashSet<Servicio>
		servicios.add(new Servicio("asistencia Social"))
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		lugano = new Comuna("lugano", new Polygon(#[new Point(2, 4), new Point(4, 5)]))
		unCGP = new CGP(servicios,new Direccion("calle sarmiento", "2142", #["san Martin", "Belgrano"], new Point(4, 6), "bs as","Buenos Aires", almagro, "1881", "", "", ""), "Centro de gestion y participacion")
		_114 = new ParadaDeColectivo(
			new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(1, 2), "bs as", "Buenos Aires",
				lugano, "1422", "", "", ""), "Parada colectivo 114")
		unaLibreria = new LibreriaEscolar(
			new Direccion("calle 848", "2114", #["893", "892"], new Point(6, 2), "bs as", "Buenos Aires", almagro,
				"1881", "", "", ""), "libreria don Pepito")
		unKiosco = new KioscoDiarios(
			new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as", "Buenos Aires",
				almagro, "3333", "", "", ""), "lo de tucu")
		unSorteaditoDePuntos = new HashSet<PuntoDeInteres>
		unSorteaditoDePuntos.addAll(#[unaLibreria, _114, unCGP, unKiosco])
		buscador = new Buscador()
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
