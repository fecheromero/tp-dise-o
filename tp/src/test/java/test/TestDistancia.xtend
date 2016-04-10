package test

import dominio.CGP
import dominio.Comuna
import dominio.Direccion
import dominio.ParadaDeColectivo
import dominio.Servicio
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon

public class TestDistancia {
	Point unPunto
	Point puntoParadaColectivo
	ParadaDeColectivo parada1
	Comuna almagro
	CGP unCGP
	CGP otroCGP
	Comuna once
	
	@Before
	def void setUp(){
		unPunto = new Point(1,2)
		puntoParadaColectivo = new Point(1,2)
		almagro=new Comuna("almagro",new Polygon(#[new Point(1,2),new Point(2,3)]))
		once=new Comuna("once", new Polygon(#[new Point(5,6),new Point(6,7)]))
		unCGP = new CGP(#[new Servicio("asistencia Social")],new Direccion("calle sarmiento","2142",#["san Martin","Belgrano"],new Point(4,6),"bs as","Buenos Aires",almagro,"1881","","",""),"Centro de gestion y participacion")
		otroCGP = new CGP(#[new Servicio("asistencia Comunitaria")],new Direccion("calle nogoya","2156",#["san Martin","Uquiza"],new Point(1,2),"bs as","Buenos Aires",once,"1881","","",""),"Centro de gestion y participacion")
	}
	@Test
	def void estaCercaDe (){
	Assert.assertEquals(unCGP.estaCercaDe(unPunto),false)
	}
	
	@Test 
    def void estaCerca (){
    Assert.assertEquals(otroCGP.estaCercaDe(unPunto),false)	
    }
}
	

