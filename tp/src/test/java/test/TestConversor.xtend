package test

import ejercicio3.Conversor
import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestConversor {
	Conversor conversor
	
	@Before
	def setUp(){
		conversor = new Conversor
		conversor.oracion="hola tarola"
		
	}
	@Test
	def testConversor(){
		conversor.convertir
		Assert.assertEquals(conversor.oracionInv,"alorat aloh")
//		System.out.println(conversor.oracionInv)		
	} 
	@Test
	def tesPalindromo(){
		conversor.oracionInv="hola tarola"
		Assert.assertTrue(conversor.esPalindromo)
	}
}
