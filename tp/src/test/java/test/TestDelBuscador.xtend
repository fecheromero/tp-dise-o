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
    HashSet<PuntoDeInteres> unSorteaditoDePuntos
	@Before
	def void setUp()
	{  string1="muebleria"
	  string2="mueble"
	  string3="sangucheria"
	 string4="embuebido"
	  string5="muebleria don pepito"
	 almagro=new Comuna("almagro",new Polygon(#[new Point(1,2),new Point(2,3)]))
	 lugano=new Comuna("lugano",new Polygon(#[new Point(2,4),new Point(4,5)]))
	  unCGP=new CGP(#[new Servicio("asistencia Social")],new Direccion("calle sarmiento","2142",#["san Martin","Belgrano"],new Point(4,6),"bs as","Buenos Aires",almagro,"1881","","",""),"Centro de gestion y participacion")
	  _114=new ParadaDeColectivo(new Direccion("Mozart","1919",#["Dellepiane","Otra calle"],new Point(1,2),"bs as","Buenos Aires",lugano,"1422","","",""),"Parada colectivo 114") 
	  unaLibreria=new LibreriaEscolar(new Direccion("calle 848","2114",#["893","892"],new Point(6,2),"bs as","Buenos Aires",almagro,"1881","","",""),"libreria don Pepito")
	 unSorteaditoDePuntos=new HashSet<PuntoDeInteres>
	 unSorteaditoDePuntos.addAll(#[unaLibreria,_114,unCGP])
	 buscador=new Buscador()
	 buscador.puntos=unSorteaditoDePuntos
	}
	@Test
	def void comprarMuebleriaConMueble()
	{
	Assert.assertEquals(buscador.masParecido("muebles en venta","venta","mueble"),"venta")
	}
   @Test
  def void laMasParecida(){
  Assert.assertEquals(buscador.seleccionarLaMasParecida(string2,#[string1,string3,string4,string5]),string1)
}
	@Test
	def void pruebaDeOrdenador(){
		Assert.assertEquals(buscador.ordenador(#[3,2,4,1]),#[1,2,3,4])
	}
	@Test
	def void pruebaDeSeparadorDePalabras(){
		Assert.assertArrayEquals(buscador.separarPalabras("palabra1 palabra2 palabra3"),#["palabra1","palabra2","palabra3"])
	}
	
	@Test
	def void listaDeTagsDe_114(){
		Assert.assertEquals(" ",_114.listaDeTags())
	}
	@Test
	def void pruebaDeBusquedaLibreriaDonPepitoEnUnSoreaditoDePuntos(){
		Assert.assertArrayEquals(buscador.topTenDePuntos("libreria don Pepito").take(1),#[unaLibreria])
	}
}
