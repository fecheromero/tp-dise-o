package test

import dominio.CGP
import dominio.Comuna
import dominio.Direccion
import dominio.Horario
import dominio.Horario.Dia
import dominio.Servicio
import dominio.Turno
import java.util.HashSet
import org.joda.time.LocalTime
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class CGPFixture {
		
//	Comuna almagro
	CGP unCGP
	HashSet<Servicio> servicios
	Horario unHorario
	HashSet<Dia> unosDias
	HashSet<Turno> unosTurnos	
	Comuna almagro	
	Servicio rentas	
	Servicio registroCivil
		
		
	def CGP obtenerCGP(Comuna comuna) {

		unosTurnos=new HashSet<Turno>
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		unosDias=new HashSet<Dia>
		unosDias.add(Dia.LUN)
		unHorario=new Horario(unosDias,unosTurnos)
		servicios = new HashSet<Servicio>
		servicios.add(new Servicio("asistencia Social",unHorario))
		unCGP = new CGP(servicios,new Direccion("calle sarmiento", "2142", #["san Martin", "Belgrano"], new Point(4, 6), "bs as","Buenos Aires", comuna, "1881", "", "", ""), "Centro de gestion y participacion")
		
		return unCGP
		
	}
	
	def CGP obtenerCGPFlores(){
		
		almagro = new Comuna("once",new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))		
		
//		var cgp = this.obtenerCGP(almagro)
		
		var diasHabilesRentas = new HashSet<Dia>
		diasHabilesRentas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE)
		var turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(13, 0))
		var turnoTarde = new Turno(new LocalTime(14, 0), new LocalTime(18, 0))
		var turnosDisponiblesRentas = new HashSet<Turno>
		turnosDisponiblesRentas.addAll(turnoMañana, turnoTarde)
		var horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas)

		var diasHabilesRegistroCivil = new HashSet<Dia>
		diasHabilesRegistroCivil.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE)
		var turnoRegistroCivil = new Turno(new LocalTime(7, 0), new LocalTime(12, 30))
		var turnosDisponiblesRegistroCivil = new HashSet<Turno>
		turnosDisponiblesRegistroCivil.add(turnoRegistroCivil)
		var horarioRegistroCivil = new Horario(diasHabilesRegistroCivil, turnosDisponiblesRegistroCivil)
		
		var registroCivil = new Servicio("Registro Civil", horarioRegistroCivil)
		var rentas = new Servicio("Rentas", horarioRentas)
		
		var serviciosCGP = new HashSet<Servicio>
		serviciosCGP.addAll(rentas, registroCivil)
		
		
		var cgpFlores = new CGP(serviciosCGP, new Direccion("calle sarmiento", "2142", #["san Martin", "Belgrano"], new Point(4, 6), "bs as","Buenos Aires", almagro, "1881", "", "", ""), "CGP FLORES")
		
		return cgpFlores
		
		}

	def void setServicios(HashSet<Servicio> servicios){
		
		this.servicios = servicios
	}
}