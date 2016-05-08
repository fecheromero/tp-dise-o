package test

import java.util.HashSet
import dominio.SucursalBanco
import dominio.tiempo.Dia
import dominio.tiempo.Turno
import org.joda.time.LocalTime
import dominio.tiempo.Horario
import dominio.pois.Comuna
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import dominio.pois.Direccion
import dominio.pois.Servicio

class SucursalBancoFixture {
	
	SucursalBanco santander
	HashSet<Dia> diasHabilesRentas	
	Turno turnoMañana	
	Turno turnoTarde
	HashSet<Turno> turnosDisponiblesRentas	
	Horario horarioRentas
	HashSet<Dia> diasHabilesCobranzas	
	Turno turnoCobranzas	
	HashSet<Turno> turnosDisponiblesCobranzas
	Horario horarioCobranzas	
	Direccion direccionBanco
	Servicio rentas
	Servicio cobranzas
	Comuna almagro
	HashSet<Servicio> serviciosBanco
	
	
	def SucursalBanco obtenerBanco(){
		
		diasHabilesRentas = new HashSet<Dia>
		diasHabilesRentas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE)
		turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(13, 0))
		turnoTarde = new Turno(new LocalTime(14, 0), new LocalTime(18, 0))
		turnosDisponiblesRentas = new HashSet<Turno>
		turnosDisponiblesRentas.addAll(turnoMañana, turnoTarde)
		horarioRentas = new Horario(diasHabilesRentas, turnosDisponiblesRentas)
		diasHabilesCobranzas = new HashSet<Dia>
		diasHabilesCobranzas.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.MIE)
		turnoCobranzas = new Turno(new LocalTime(8, 0), new LocalTime(16, 0))
		turnosDisponiblesCobranzas = new HashSet<Turno>
		turnosDisponiblesCobranzas.add(turnoCobranzas)
		horarioCobranzas = new Horario(diasHabilesCobranzas, turnosDisponiblesRentas)

		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		direccionBanco = new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as",
			"Buenos Aires", almagro, "3333", "", "", "")

		rentas = new Servicio("Rentas", horarioRentas)
		cobranzas = new Servicio("Cobranzas", horarioCobranzas)
		serviciosBanco = new HashSet<Servicio>
		serviciosBanco.addAll(rentas, cobranzas)

		santander = new SucursalBanco(serviciosBanco, direccionBanco, "santander rio 8")
		
		return santander
	}

}