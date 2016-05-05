package test

import dominio.CentroDTO
import dominio.ServicioDTO
import dominio.RangoServicioDTO
import org.junit.Before
import java.util.ArrayList
import org.uqbar.geodds.Point
import org.junit.Test
import dominio.Repositorio
import dominio.ServicioExterno
import dominio.Transformer
import dominio.Direccion
import dominio.Comuna
import dominio.CGP
import org.uqbar.geodds.Polygon
import dominio.Servicio
import dominio.Horario
import dominio.Turno
import org.joda.time.LocalTime
import org.junit.Assert
import com.google.common.collect.Sets
import dominio.Horario.Dia
import java.util.HashSet

class TestCGPsExternos {

	StubServicioExterno servicioExt

	CentroDTO centro1
	CentroDTO centro2

	ServicioDTO servicio1
	ServicioDTO servicio2
	ServicioDTO servicio3
	ServicioDTO servicio4

	RangoServicioDTO rango1
	RangoServicioDTO rango2
	RangoServicioDTO rango3
	RangoServicioDTO rango4

	Transformer trafo = new Transformer
	
	@Before
	def void setUp() {
		servicioExt= new StubServicioExterno
		rango1 = new RangoServicioDTO(1, 9, 0, 18, 0)
		rango2 = new RangoServicioDTO(2, 9, 0, 18, 0)
		rango3 = new RangoServicioDTO(3, 10, 0, 18, 0)
		rango4 = new RangoServicioDTO(4, 10, 0, 18, 0)
		var rangos1 = new ArrayList<RangoServicioDTO>(#[rango1, rango2])
		var rangos2 = new ArrayList<RangoServicioDTO>(#[rango3, rango4])
		

		servicio1 = new ServicioDTO("Tesoreria", rangos1)
		servicio2 = new ServicioDTO("Rentas", rangos1)
		servicio3 = new ServicioDTO("Atencion Ciudadana", rangos2)
		servicio4 = new ServicioDTO("Registro Civil", rangos2)

		var servicios1 = new ArrayList<ServicioDTO>(#[servicio1, servicio2])
		var servicios2 = new ArrayList<ServicioDTO>(#[servicio3, servicio4])

		centro1 = new CentroDTO("Elba Gallo", 3, "Junin 521", "Balvanera,SanCristobal", "43750644/45",
			new Point(100, 300), servicios1)
		centro2 = new CentroDTO("Elmo Coso", 3, "Rivadavia 4577", "Almagro,Pch", "49375470/87", new Point(432, 967),
			servicios2)
		
		//horarioExt=trafo.horarioServicioDTO(servicio1)
	}

	
//	def void testTransformarCentroACGP() {
//		val direccion = new Direccion("Junin 521", "", #["", ""], new Point(432, 967), "Balvanera,SanCristobal", "",new Comuna("", new Polygon(#[new Point(0, 0), new Point(0, 0)])), "", "", "", "")
//		
//		val cgp1 = new CGP(servicios, direccion, "")
//		trafo.centroACGP(centro1)
//	}
//	
//	def Servicio testServicioDTOAServicio(){
//		
//	}

	@Test
	def void testRangoAHorario(){
				
		val dias= new HashSet<Dia>
		dias.addAll(Dia.LUN,Dia.MAR)
		val turnos=new HashSet<Turno>
		turnos.addAll(new Turno(new LocalTime(9,0),new LocalTime(18,0)))
		val horario1=new Horario(dias, turnos)
		val horarioExterno=trafo.horarioServicioDTO(servicio1)		
		Assert.assertEquals(#[Dia.LUN,Dia.MAR],horarioExterno.diasHabilesPoi)
	}
}
