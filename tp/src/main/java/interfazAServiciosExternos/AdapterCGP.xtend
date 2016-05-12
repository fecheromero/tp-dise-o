package interfazAServiciosExternos

import dominio.pois.CGP
import dominio.pois.Comuna
import dominio.pois.Direccion
import dominio.tiempo.Horario
import dominio.tiempo.Dia
import dominio.pois.Servicio
import dominio.tiempo.Turno
import java.util.ArrayList
import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalTime
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import stubs.CentroDTO
import stubs.ServicioDTO
import stubs.RangoServicioDTO

@Accessors
public class AdapterCGP {
	
	def HashSet<CGP> centrosACGPs(ArrayList<CentroDTO> listaDeCentros){
		val arrayCGPs = listaDeCentros.map[unCentro|this.centroACGP(unCentro)]
		val listaCGPs = new HashSet<CGP>(arrayCGPs)
		return listaCGPs
	}
	def CGP centroACGP(CentroDTO centro) {
		val lista = centro.serviciosDTO.map[unServicio|this.servicioDtoAServicio(unServicio)]
		val servicios = new HashSet<Servicio>(lista)
		val cgp = new CGP(servicios, this.direccionDeCentroDTO(centro), "CGP" + centro.numeroComuna.toString)
		return cgp
	}

	// Modelado de la direccion
	def Direccion direccionDeCentroDTO(CentroDTO centro) {
		val direccion = new Direccion(centro.domicilio, "", #["", ""], centro.coordenadas, centro.zonasIncluidas, "",
			new Comuna("", new Polygon(#[new Point(0, 0), new Point(0, 0)])), "", "", "", "")
		return direccion
	}

	// Modelado del servicio
	def Servicio servicioDtoAServicio(ServicioDTO servicioExt) {
		val servicio = new Servicio(servicioExt.nombreServicio, this.horarioServicioDTO(servicioExt))
		return servicio
	}

	// Modelado del horario de cada servicio
	def Horario horarioServicioDTO(ServicioDTO servicio) {
		val horario = new Horario(this.rangosADias(servicio.rangosServicioDTO), this.rangoATurnos(servicio))
		return horario
	}

	def HashSet<Turno> rangoATurnos(ServicioDTO servicio) {
		val rango = servicio.rangosServicioDTO.get(1)
		val turnos = new HashSet<Turno>
		val turno = new Turno(new LocalTime(rango.horarioDesde, rango.minutosDesde),
			new LocalTime(rango.horarioHasta, rango.minutosHasta))
		turnos.add(turno)
		return turnos
	}

	def Dia enteroADia(int entero) {

		switch (entero) {
			case 1: Dia.LUN
			case 2: Dia.MAR
			case 3: Dia.MIE
			case 4: Dia.JUE
			case 5: Dia.VIE
			case 6: Dia.SAB
			case 7: Dia.DOM
		}
	}

	def HashSet<Dia> rangosADias(ArrayList<RangoServicioDTO> rangos) {

		val diasEnteros = rangos.map[unRango|this.enteroADia(unRango.numeroDia)]
		val dias = new HashSet<Dia>(diasEnteros)

		return dias
	}
	
	
}
