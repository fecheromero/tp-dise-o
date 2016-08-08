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

class BusquedaBootstrap extends CollectionBasedBootstrap{
	
		new() {
		ApplicationContext.instance.configureSingleton(typeof(Busqueda), new Busqueda)
	}
		override run(){
			val repo = Repositorio.getInstance
		var almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		var _114 = new ParadaDeColectivo(
				new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(0, 1), "bs as", "Buenos Aires",
				almagro, "1422", "", "", ""), "Parada colectivo 114")
		
		
		repo.create(_114)
		var Busqueda context=ApplicationContext.instance.getSingleton(typeof(Busqueda)) as Busqueda
		context.agregarOrigen(repo)
		}
		}
