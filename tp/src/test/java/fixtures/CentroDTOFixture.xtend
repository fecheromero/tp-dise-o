package fixtures

import stubs.CentroDTO
import stubs.ServicioDTO
import stubs.RangoServicioDTO
import java.util.ArrayList
import org.uqbar.geodds.Point

class CentroDTOFixture {

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

	def CentroDTO centro1() {

		rango1 = new RangoServicioDTO(1, 9, 0, 18, 0)
		rango2 = new RangoServicioDTO(2, 9, 0, 18, 0)
		var rangos1 = new ArrayList<RangoServicioDTO>(#[rango1, rango2])

		servicio1 = new ServicioDTO("Tesoreria", rangos1)
		servicio2 = new ServicioDTO("Rentas", rangos1)

		var servicios1 = new ArrayList<ServicioDTO>(#[servicio1, servicio2])

		centro1 = new CentroDTO("Elba Gallo", 3, "Junin 521", "Balvanera,SanCristobal", "43750644/45",
			new Point(100, 300), servicios1)

		return centro1
	}

	def CentroDTO centro2() {

		rango3 = new RangoServicioDTO(3, 10, 0, 18, 0)
		rango4 = new RangoServicioDTO(4, 10, 0, 18, 0)
		var rangos2 = new ArrayList<RangoServicioDTO>(#[rango3, rango4])
		
		servicio3 = new ServicioDTO("Atencion Ciudadana", rangos2)
		servicio4 = new ServicioDTO("Registro Civil", rangos2)
		
		var servicios2 = new ArrayList<ServicioDTO>(#[servicio3, servicio4])
		
		centro2 = new CentroDTO("Elmo Coso", 4, "Rivadavia 4577", "Almagro,Pch", "49375470/87", new Point(432, 967),
			servicios2)

		return centro2
	}
}
