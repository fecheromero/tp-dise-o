package test

import dominio.ParadaDeColectivo
import org.uqbar.geodds.Point
import dominio.pois.Direccion
import dominio.pois.Comuna
import org.uqbar.geodds.Polygon

class ParadaColectivoFixture {
	
	Comuna almagro
	ParadaDeColectivo _114
	
	def ParadaDeColectivo obtenerParadaColectivo(){
		
		almagro = new Comuna("almagro", new Polygon(#[new Point(1, 2), new Point(2, 3)]))
		
		_114 = new ParadaDeColectivo(
				new Direccion("Mozart", "1919", #["Dellepiane", "Otra calle"], new Point(0, 1), "bs as", "Buenos Aires",
				almagro, "1422", "", "", ""), "Parada colectivo 114")
				
		return _114
	}

}