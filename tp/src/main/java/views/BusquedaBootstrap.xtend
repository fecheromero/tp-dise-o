package views

import org.uqbar.commons.utils.ApplicationContext
import dominio.Repositorio


import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import dominio.pois.Comuna
import dominio.pois.ParadaDeColectivo
import dominio.pois.Direccion
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import dominio.Busqueda
import java.util.HashSet
import dominio.tiempo.Turno
import org.joda.time.LocalTime
import dominio.tiempo.Dia
import dominio.tiempo.Horario
import dominio.locales.LocalComercial
import dominio.locales.Rubro

class BusquedaBootstrap extends CollectionBasedBootstrap{
	
		new() {
		ApplicationContext.instance.configureSingleton(typeof(Busqueda), new Busqueda)
	}
		override run(){
			val repo = Repositorio.getInstance
			
			//No puedo usar los Fixtures, fijense si alguno lo puede arreglar. Tira error de consola
		var almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		var _114 = new ParadaDeColectivo(
				new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(0, 1), "bs as", "Buenos Aires",
				almagro, "1422", "", "", ""), "Parada colectivo 114")
		
		var		unosTurnos=new HashSet<Turno>
		
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		
		var unosDias=new HashSet<Dia>
		
		unosDias.add(Dia.LUN)
		
		var unHorario=new Horario(unosDias,unosTurnos)
		
		var unKiosco = new LocalComercial("lo de tucu",unHorario,
					new Direccion("calle pepe", "3333", #["jorge", "roberto"], new Point(1, 0), "bs as", "Buenos Aires",
					almagro, "3333", "", "", ""), new Rubro("Kiosko de Diarios", 0.2))

						
		repo.create(_114)
		repo.create(unKiosco)
		var Busqueda context=ApplicationContext.instance.getSingleton(typeof(Busqueda)) as Busqueda
		context.agregarOrigen(repo)
		}
		}
