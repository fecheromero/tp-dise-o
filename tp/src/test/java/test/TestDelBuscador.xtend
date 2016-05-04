package test

import dominio.Buscador
import dominio.CGP
<<<<<<< HEAD
import dominio.Comuna
import dominio.Direccion
import dominio.Horario
import dominio.LocalComercial
import dominio.ParadaDeColectivo
import dominio.PuntoDeInteres
import dominio.Servicio
import dominio.Turno
import dominio.Rubro
import java.util.HashSet
import org.joda.time.LocalTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import dominio.Horario.Dia
import excepciones.NoValidoException
=======
import dominio.LocalComercial
import dominio.ParadaDeColectivo
import dominio.PuntoDeInteres
import java.util.HashSet
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.Comuna
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
>>>>>>> development

public class TestDelBuscador {
	Buscador buscador
	String string1
	String string2
	String string3
<<<<<<< HEAD

	String string4
	String string5
	Comuna almagro
	Comuna lugano
	CGP unCGP
=======
	String string4
	String string5
	CGP unCGP
	Comuna almagro
>>>>>>> development
	ParadaDeColectivo _114
	LocalComercial unaLibreria
	LocalComercial unKiosco
	HashSet<PuntoDeInteres> unSorteaditoDePuntos
<<<<<<< HEAD
	HashSet<Servicio> servicios
	Horario unHorario
	HashSet<Dia> unosDias
	HashSet<Turno> unosTurnos

	@Before
	def void setUp() {
=======
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
		
>>>>>>> development
		string1 = "muebleria"
		string2 = "mueble"
		string3 = "sangucheria"
		string4 = "embuebido"
		string5 = "muebleria don pepito"
<<<<<<< HEAD
		unosTurnos=new HashSet<Turno>
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		unosDias=new HashSet<Dia>
		unosDias.add(Dia.LUN)
		unHorario=new Horario(unosDias,unosTurnos)
		servicios = new HashSet<Servicio>
		servicios.add(new Servicio("asistencia Social",unHorario))
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		lugano = new Comuna("lugano", new Polygon(#[new Point(2, 4), new Point(4, 5)]))
		unCGP = new CGP(servicios,new Direccion("calle sarmiento", "2142", #["san Martin", "Belgrano"], new Point(4, 6), "bs as","Buenos Aires", almagro, "1881", "", "", ""), "Centro de gestion y participacion")
		_114 = new ParadaDeColectivo(
			new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(1, 2), "bs as", "Buenos Aires",
				lugano, "1422", "", "", ""), "Parada colectivo 114")
		unaLibreria = new LocalComercial("libreria don Pepito",unHorario,
			new Direccion("calle 848", "2114", #["893", "892"], new Point(6, 2), "bs as", "Buenos Aires", almagro,
				"1881", "", "", ""), new Rubro("Libreria Comercial", 0.5))
		unKiosco = new LocalComercial("lo de tucu",unHorario,
			new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as", "Buenos Aires",
				almagro, "3333", "", "", ""), new Rubro("Kiosko de Diarios", 0.2))
		unSorteaditoDePuntos = new HashSet<PuntoDeInteres>
		unSorteaditoDePuntos.addAll(#[unaLibreria, _114, unCGP, unKiosco])
		buscador = new Buscador()
	
=======
		
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		unCGP = cgpFixture.obtenerCGP(almagro)
		
		_114 = paradaFixture.obtenerParadaColectivo
		
		unaLibreria = libreriaFixture.obtenerLibreria
		
		unKiosco = kioscoFixture.obtenerKiosco
		
		unSorteaditoDePuntos = new HashSet<PuntoDeInteres>
		unSorteaditoDePuntos.addAll(#[unaLibreria, _114, unCGP, unKiosco])
		
		buscador = new Buscador()
		buscador.puntos = unSorteaditoDePuntos
>>>>>>> development
		

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
<<<<<<< HEAD
		Assert.assertArrayEquals(buscador.mostrarPrimeros("libreria don Pepito",unSorteaditoDePuntos,10).take(1), #[unaLibreria])
=======
		Assert.assertArrayEquals(buscador.topTenDePuntos("libreria don Pepito").take(1), #[unaLibreria])
>>>>>>> development
	}

	@Test
	def void pruebaDeBusquedaParadaDel114EnUnSorteaditoDePuntos() {
<<<<<<< HEAD
		Assert.assertArrayEquals(buscador.mostrarPrimeros("114",unSorteaditoDePuntos,10).take(1), #[_114])
=======
		Assert.assertArrayEquals(buscador.topTenDePuntos("114").take(1), #[_114])
>>>>>>> development

	}

	@Test
	def void pruebaDeBusquedaxRubroKioscoEnUnSorteaditoDePuntos() {
<<<<<<< HEAD
		Assert.assertArrayEquals(buscador.mostrarPrimeros("kiosco",unSorteaditoDePuntos,10).take(1), #[unKiosco])
=======
		Assert.assertArrayEquals(buscador.topTenDePuntos("kiosco").take(1), #[unKiosco])
>>>>>>> development
	}



}
