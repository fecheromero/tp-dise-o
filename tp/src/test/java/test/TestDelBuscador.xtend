package test
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import dominio.*
public class TestDelBuscador {
	Buscador buscador
	String string1
	String string2
	String string3
    String string4
    String string5
	@Before
	def void setUp()
	{  string1="muebleria"
	  string2="mueble"
	  string3="sangucheria"
	 string4="embuebido"
	  string5="muebleria don pepito"
	  
	 buscador=new Buscador()
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
}
