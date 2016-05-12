package test

import dominio.pois.CGP
import fixtures.CentroDTOFixture
import interfazAServiciosExternos.AdapterCGP
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import stubs.CentroDTO
import fixtures.CGPFixture

class TestConversorCGPsExternos {


		AdapterCGP trafo = new AdapterCGP
		CentroDTOFixture fixtureCentro= new CentroDTOFixture
		CGPFixture fixtureCGP = new CGPFixture
		
		CentroDTO centro1
		CentroDTO centro2
		CGP cgpAlmagro
	
	@Before
	def void setUp() {
			centro1= fixtureCentro.centro1	
			centro2= fixtureCentro.centro2	
			cgpAlmagro=fixtureCGP.obtenerCGPAlmagro
			
	}

	
	@Test
	def void testCentroACGP(){
		var cgpExt=trafo.centroACGP(centro1)
		cgpExt.validate
		Assert.assertEquals(cgpExt.nombre,cgpAlmagro.nombre)
					
	}
		
//	@Test
//	def void testRangoAHorario(){
//				
//		var dias= new HashSet<Dia>
//		dias.addAll(Dia.LUN,Dia.MAR)
//		var turnos=new HashSet<Turno>
//		turnos.addAll(new Turno(new LocalTime(9,0),new LocalTime(18,0)))
//		val horarioExterno=trafo.horarioServicioDTO(servicio1)		
//		Assert.assertTrue(dias==horarioExterno.diasHabilesPoi)
//	}
}
