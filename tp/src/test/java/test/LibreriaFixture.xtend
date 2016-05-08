package test

import java.util.HashSet
import dominio.locales.LocalComercial
import dominio.tiempo.Horario
import dominio.tiempo.Horario.Dia
import dominio.tiempo.Turno
import dominio.pois.Direccion
import dominio.locales.Rubro
import org.uqbar.geodds.Point
import dominio.pois.Comuna
import org.uqbar.geodds.Polygon
import org.joda.time.LocalTime

class LibreriaFixture {
	
	LocalComercial unaLibreria
	Horario unHorario
	HashSet<Dia> unosDias
	HashSet<Turno> unosTurnos
	Comuna almagro
	
	def LocalComercial obtenerLibreria(){
		
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		unosTurnos=new HashSet<Turno>
		
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		
		unosDias=new HashSet<Dia>
		
		unosDias.add(Dia.LUN)
		
		unHorario=new Horario(unosDias,unosTurnos)
		
		unaLibreria = new LocalComercial("libreria don Pepito",unHorario,
						new Direccion("calle 848", "2114", #["893", "892"], new Point(6, 2), "bs as", "Buenos Aires", almagro,
						"1881", "", "", ""), new Rubro("Libreria Comercial", 0.5))
						
		return unaLibreria
		
	}
	
		def LocalComercial obtenerCarroussel(){
		
		var once = new Comuna("once",new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))
		var diasHabilesCarrousel = new HashSet<Dia>
		diasHabilesCarrousel.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.VIE, Dia.SAB)
		var turnoMañanaCarrousel = new Turno(new LocalTime(10, 0), new LocalTime(13, 0))
		var turnoTardeCarrousel = new Turno(new LocalTime(17, 0), new LocalTime(20, 30))
		var turnosDisponiblesCarrousel = new HashSet<Turno>
		turnosDisponiblesCarrousel.addAll(turnoMañanaCarrousel, turnoTardeCarrousel)
		var horarioCarrousel = new Horario(diasHabilesCarrousel, turnosDisponiblesCarrousel)
		
		var direccionCarroussel = new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as",
			"Buenos Aires", once, "3333", "", "", "")
			
		var unRubro = new Rubro("Libreria Comercial", 0.2)
			
		var carroussel =new LocalComercial("Libreria Carrousel", horarioCarrousel, direccionCarroussel, unRubro)
		
		return carroussel
	}

}