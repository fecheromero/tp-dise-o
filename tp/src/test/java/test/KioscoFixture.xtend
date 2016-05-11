package test

import dominio.Comuna
import java.util.HashSet
import dominio.Turno
import dominio.Dia
import dominio.Horario
import dominio.LocalComercial
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point
import org.joda.time.LocalTime
import dominio.Direccion
import dominio.Rubro

class KioscoFixture {
	
	LocalComercial unKiosco
	Horario unHorario
	HashSet<Dia> unosDias
	HashSet<Turno> unosTurnos
	Comuna almagro
	
	def LocalComercial obtenerKiosco(){
		
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		unosTurnos=new HashSet<Turno>
		
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		
		unosDias=new HashSet<Dia>
		
		unosDias.add(Dia.LUN)
		
		unHorario=new Horario(unosDias,unosTurnos)
		
		unKiosco = new LocalComercial("lo de tucu",unHorario,
					new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as", "Buenos Aires",
					almagro, "3333", "", "", ""), new Rubro("Kiosko de Diarios", 0.2))

						
		return unKiosco
	}

}