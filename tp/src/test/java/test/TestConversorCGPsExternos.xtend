package test

import dominio.CentroDTO
import dominio.ServicioDTO
import dominio.RangoServicioDTO
import org.junit.Before
import java.util.ArrayList
import org.uqbar.geodds.Point
import org.junit.Test
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
import dominio.Horario.Dia
import java.util.HashSet

class TestConversorCGPsExternos {

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

	
	@Test
	def void testCentroACGP(){
		var	almagro = new Comuna("", new Polygon(#[new Point(0, 0), new Point(0, 0)]))		
		
		var diasHabilesRentas = new HashSet<Dia>
		diasHabilesRentas.addAll(Dia.LUN, Dia.MAR)
		var turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(18, 0))
		var turnosDisponiblesRentas = new HashSet<Turno>
		turnosDisponiblesRentas.addAll(turnoMañana)
		var horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas)

		var diasHabilesTesoreria = new HashSet<Dia>
		diasHabilesTesoreria.addAll(Dia.LUN, Dia.MAR)
		var turnoTesoreria = new Turno(new LocalTime(9, 0), new LocalTime(18, 0))
		var turnosDisponiblesTesoreria = new HashSet<Turno>
		turnosDisponiblesTesoreria.add(turnoTesoreria)
		var horarioTesoreria = new Horario(diasHabilesTesoreria, turnosDisponiblesTesoreria)
		
		var tesoreria = new Servicio("Registro Civil", horarioTesoreria)
		var rentas = new Servicio("Rentas", horarioRentas)
		
		var serviciosCGP = new HashSet<Servicio>
		serviciosCGP.addAll(rentas, tesoreria)
		
		var cgpFlores = new CGP(serviciosCGP, new Direccion("Junin 521", "", #["", ""], new Point(100, 300), "Balvanera,SanCristobal","", almagro, "", "", "", ""), "CGP3")
		var cgpExt=trafo.centroACGP(centro1)
		Assert.assertEquals(cgpExt.nombre,cgpFlores.nombre)	
	}
		
	@Test
	def void testRangoAHorario(){
				
		var dias= new HashSet<Dia>
		dias.addAll(Dia.LUN,Dia.MAR)
		var turnos=new HashSet<Turno>
		turnos.addAll(new Turno(new LocalTime(9,0),new LocalTime(18,0)))
		val horarioExterno=trafo.horarioServicioDTO(servicio1)		
		Assert.assertTrue(dias==horarioExterno.diasHabilesPoi)
	}
}
