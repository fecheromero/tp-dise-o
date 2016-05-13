package test

import dominio.pois.CGP
import fixtures.CentroDTOFixture
import interfazAServiciosExternos.AdapterCGP
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import stubs.CentroDTO
import fixtures.CGPFixture
import java.util.List
import dominio.pois.PuntoDeInteres
import java.util.ArrayList

class TestConversorCGPsExternos {


		AdapterCGP trafo = new AdapterCGP
		CentroDTOFixture fixtureCentro= new CentroDTOFixture
		CGPFixture fixtureCGP = new CGPFixture
		
		CentroDTO centro1
		CentroDTO centro2
		CGP cgpAlmagro
		CGP cgpBoedo
		List<PuntoDeInteres> listaDeCGPs
		ArrayList<CentroDTO> arrayDeCentros

	@Before
	def void setUp() {
			listaDeCGPs=new ArrayList<PuntoDeInteres>
			arrayDeCentros=new ArrayList<CentroDTO>
			centro1= fixtureCentro.centro1	
			centro2= fixtureCentro.centro2	
			cgpAlmagro=fixtureCGP.obtenerCGPAlmagro
			cgpBoedo=fixtureCGP.obtenerCGPBoedo
			listaDeCGPs.add(cgpAlmagro)
			listaDeCGPs.add(cgpBoedo)
			arrayDeCentros.add(centro1)			
			arrayDeCentros.add(centro2)
	}

	
	@Test
	def void testCentro1ACGP(){
		var cgpExt=trafo.centroACGP(centro1)
		cgpExt.validate
		Assert.assertEquals(cgpExt.nombre,cgpAlmagro.nombre)
	}
	@Test
	def void testCentro2ACGP(){
		var cgpExt=trafo.centroACGP(centro2)
		cgpExt.validate
		Assert.assertEquals(cgpExt.nombre,cgpBoedo.nombre)
	}
	@Test
	def void testArrayDeCentrosACGPs(){
		var nombresCentro=trafo.centrosACGPs(arrayDeCentros).map[unCentro|unCentro.nombre]
		var nombresCGPs=listaDeCGPs.map[unCGP|unCGP.nombre]
		Assert.assertEquals(nombresCGPs,nombresCentro)
	}
	@Test
	def void testServiciosDeCentro1AServiciosDeCGP(){
		var nombresDeServiciosCentro=centro1.serviciosDTO.map[unServicio|unServicio.nombreServicio]
//		var nombresServiciosCGP=cgpAlmagro.servicios.map[unServicio|unServicio.nombre]
		Assert.assertTrue(nombresDeServiciosCentro.contains("Tesoreria"))
		Assert.assertTrue(nombresDeServiciosCentro.contains("Rentas"))
	}
	@Test
	def void testServiciosDeCentro2AServiciosDeCGP(){
		var nombresDeServiciosCentro=centro2.serviciosDTO.map[unServicio|unServicio.nombreServicio]
//		var nombresServiciosCGP=cgpBoedo.servicios.map[unServicio|unServicio.nombre]
		Assert.assertTrue(nombresDeServiciosCentro.contains("Registro Civil"))
		Assert.assertTrue(nombresDeServiciosCentro.contains("Atencion Ciudadana"))
	}
	
		
}
