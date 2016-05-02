package test

import dominio.CGP
import dominio.Comuna
import dominio.Direccion
import dominio.Horario
import dominio.LocalComercial
import dominio.Rubro
import dominio.ParadaDeColectivo
import dominio.Servicio
import dominio.Turno
import java.util.HashSet
import org.joda.time.LocalTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import dominio.Horario.Dia

public class TestDistancia {
	Point unPunto
	Point puntoParadaColectivo
	Comuna almagro
	CGP unCGP
	CGP otroCGP
	Comuna once
	ParadaDeColectivo _114
	LocalComercial unaLibreria
	LocalComercial unKiosco
	HashSet<Servicio> serviciosCgp1
	HashSet<Servicio> serviciosCgp2
	Horario unHorario
	HashSet<Dia> unosDias
	HashSet<Turno> unosTurnos

	@Before
	def void setUp() {
		unPunto = new Point(1, 2)
		puntoParadaColectivo = new Point(1, 2)
		unosTurnos = new HashSet<Turno>
		unosTurnos.add(new Turno(new LocalTime(0, 10), new LocalTime(2, 4)))
		unosDias = new HashSet<Dia>
		unosDias.add(Dia.LUN)
		unHorario = new Horario(unosDias, unosTurnos)
		serviciosCgp1 = new HashSet<Servicio>
		serviciosCgp1.addAll(new Servicio("asistencia Social", unHorario),
			new Servicio("asistencia Comunitaria", unHorario))
		serviciosCgp2 = new HashSet<Servicio>
		serviciosCgp2.addAll(new Servicio("asistencia Social", unHorario),
			new Servicio("asistencia Jurídica", unHorario), new Servicio("Registro Civil", unHorario))
		
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		once = new Comuna("once", new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))
		unCGP = new CGP(serviciosCgp1,
			new Direccion("calle sarmiento", "2142", #["san Martin", "Belgrano"], new Point(4, 6), "bs as",
				"Buenos Aires", almagro, "1881", "", "", ""), "Centro de gestion y participacion")
		otroCGP = new CGP(serviciosCgp2,
			new Direccion("calle nogoya", "2156", #["san Martin", "Uquiza"], new Point(1, 2), "bs as", "Buenos Aires",
				once, "1881", "", "", ""), "Centro de gestion y participacion")
		_114 = new ParadaDeColectivo(
			new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(0, 1), "bs as", "Buenos Aires",
				almagro, "1422", "", "", ""), "Parada colectivo 114")
		unaLibreria = new LocalComercial("libreria don Pepito",unHorario,
			new Direccion("calle 848", "2114", #["893", "892"], new Point(6, 2), "bs as", "Buenos Aires", almagro,
				"1881", "", "", ""), new Rubro("Libreria Comercial", 0.5))
		unKiosco = new LocalComercial("lo de tucu",unHorario,
			new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as", "Buenos Aires",
				almagro, "3333", "", "", ""), new Rubro("Kiosko de Diarios", 0.2))

	}

	// 1 unidad en coordenadas geograficas son aproximadamente 110,59 km
	@Test
	def void estaCercaDeUnCGPAUnPuntoFueraDeSuComuna() {
		Assert.assertEquals(unCGP.estaCercaDe(unPunto), false)
	}

	@Test
	def void estaCercaUnCGPAUnPuntoDentroDeSuComuna() {
		Assert.assertEquals(otroCGP.estaCercaDe(unPunto), true)
	}

	@Test
	def void estaCercaUnaParadaDeColectivoDePuntoAMenosDe1Cuadra() {
		Assert.assertEquals(_114.estaCercaDe(new Point(0, 1.0005)), true)
	}

	@Test
	def void NoestaCercaUnaParadaDeColectivoDeUnPuntoAMasDeUnaCuadra() {
		Assert.assertEquals(_114.estaCercaDe(new Point(0, 1.0014)), false)
	}

	@Test
	def void NoEstaCercaUnaLibreriaAUnPuntoAMasDe5Cuadras() {
		Assert.assertEquals(unaLibreria.estaCercaDe(new Point(6, 2.013)), false)
	}

	@Test
	def void NoEstaCercaUnKioscoAUnPuntoAMasDe2Cuadras() {
		Assert.assertEquals(unKiosco.estaCercaDe(new Point(1, 0.0019)), true)
	}
}
