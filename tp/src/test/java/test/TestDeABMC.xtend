package test

import dominio.*
import dominio.Horario.Dia
import java.util.HashSet
import org.junit.Before
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import org.joda.time.LocalTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import excepciones.NoValidoException

class TestDeABMC {
	Buscador buscador
	ParadaDeColectivo _114
	LocalComercial unaLibreria
	LocalComercial unKiosco
	HashSet<PuntoDeInteres> unSorteaditoDePuntos
	HashSet<Servicio> servicios
	Horario unHorario
	HashSet<Dia> unosDias
	HashSet<Turno> unosTurnos
	Comuna almagro
	Comuna lugano
	CGP unCGP
	
	@Before
	def void setUp(){
		buscador=new Buscador
		buscador.puntos=new HashSet<PuntoDeInteres>
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
	}
		@Test(expected=NoValidoException)
	def void pruebaDeExcepcionDeUnPuntoConUnCampoEnNull(){
		val punto=new LocalComercial("elKiosquito",unHorario,null,new Rubro("Kiosko de Diarios", 0.2))
		punto.validate()
	}
	@Test(expected=NoValidoException)
	def void pruebaDeExcepcionesDeUnPuntoCompletoCuyaDireccionTieneUnCampoNull(){
		val punto=new LocalComercial("elKiosquito",unHorario,new Direccion(null, "3333", null, new Point(1, 0), "bs as", "Buenos Aires",
				almagro, "3333", "", "", ""),new Rubro("Kiosco de Diarios",0.2))
		punto.validate()
	}
	@Test
	def void testDeCreacionDePuntos(){
		buscador.create(_114)
		Assert.assertEquals(buscador.puntos.size,1)
	} 
	@Test(expected=NoValidoException)
	def void TestCreacionTiraErrorConUnPuntoIncompleto(){
		unaLibreria.nombre=null
		buscador.create(unaLibreria)
		
	}
	@Test(expected=NoValidoException)
	def void NoSePuedeAgregarUnPuntoYaExistente(){
		buscador.create(_114)
		buscador.create(_114)
	}
	@Test
	def void TesteliminacionDeUnPunto(){
		buscador.create(_114)
		Assert.assertEquals(buscador.puntos.size,1)
		buscador.delete(_114)
		Assert.assertEquals(buscador.puntos.size,0)
		
	}
	@Test(expected=NoValidoException)
	def void TesteliminacionDeUnPuntoQueNoExisteTiraExcepcion(){
		buscador.delete(_114)
	}
	@Test
	def void TestUpdateDeUnPunto(){
		buscador.create(_114)
		_114.nombre="nombreDeBondi"
		buscador.update(_114)
		Assert.assertEquals(buscador.puntos.get(0).nombre,"nombreDeBondi")
	}
	@Test(expected=NoValidoException)
	def void TestUpdateIntentaUpdatearUnPuntoQueNoExiste(){
		buscador.update(_114)
	}
	@Test
	def void TestBuscarPorId(){
		buscador.create(_114)
		buscador.create(unaLibreria)
		Assert.assertEquals(buscador.searchBynd(1),_114)
		Assert.assertEquals(buscador.searchBynd(0),unaLibreria)
		
	}
	}