package dependencias

import java.util.HashSet
import dominio.pois.Servicio
import dominio.tiempo.Horario
import dominio.tiempo.Turno
import dominio.tiempo.Dia
import dominio.pois.Comuna
import org.joda.time.LocalTime
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import dominio.pois.CGP
import dominio.pois.Direccion
import dominio.locales.LocalComercial
import dominio.locales.Rubro
import dominio.pois.ParadaDeColectivo
import dominio.pois.SucursalBanco

class Bootstrap {
	
		def CGP obtenerCGPFlores(){
		
		var almagro = new Comuna("once",new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))		
		
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
	def LocalComercial obtenerKiosco(){
		
		var almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		var unosTurnos=new HashSet<Turno>
		
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		
		var unosDias=new HashSet<Dia>
		
		unosDias.add(Dia.LUN)
		
		var unHorario=new Horario(unosDias,unosTurnos)
		
		var unKiosco = new LocalComercial("lo de tucu",unHorario,
					new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as", "Buenos Aires",
					almagro, "3333", "", "", ""), new Rubro("Kiosko de Diarios", 0.2))

						
		return unKiosco
	}
	def ParadaDeColectivo obtenerParadaColectivo(){
		
		var almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		var _114 = new ParadaDeColectivo(
				new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(0, 1), "bs as", "Buenos Aires",
				almagro, "1422", "", "", ""), "Parada colectivo 114")
				
		return _114
	}

	def SucursalBanco obtenerBanco(){
		
		var diasHabilesRentas = new HashSet<Dia>
		diasHabilesRentas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE)
		var turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(13, 0))
		var turnoTarde = new Turno(new LocalTime(14, 0), new LocalTime(18, 0))
		var turnosDisponiblesRentas = new HashSet<Turno>
		turnosDisponiblesRentas.addAll(turnoMañana, turnoTarde)
		var horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas)
		var diasHabilesCobranzas = new HashSet<Dia>
		diasHabilesCobranzas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.MIE)
		var turnoCobranzas = new Turno(new LocalTime(8, 0), new LocalTime(16, 0))
		var turnosDisponiblesCobranzas = new HashSet<Turno>
		turnosDisponiblesCobranzas.add(turnoCobranzas)
		var horarioCobranzas = new Horario(diasHabilesCobranzas, turnosDisponiblesRentas)

		var almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		var direccionBanco = new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as",
			"Buenos Aires", almagro, "3333", "", "", "")

		var rentas = new Servicio("Rentas", horarioRentas)
		var cobranzas = new Servicio("Cobranzas", horarioCobranzas)
		var serviciosBanco = new HashSet<Servicio>
		serviciosBanco.addAll(rentas, cobranzas)

		var santander = new SucursalBanco(serviciosBanco, direccionBanco, "santander rio 8")
		
		return santander
	}

}