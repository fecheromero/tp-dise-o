package dominio

import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalTime
import dominio.Horario.Dia
import java.util.ArrayList
import org.uqbar.geodds.Polygon
import org.uqbar.geodds.Point

import java.lang.reflect.Type
import com.google.gson.Gson
import com.google.common.collect.Sets
import com.google.gson.reflect.TypeToken

@Accessors
public class Transformer {

	def CGP centroACGP(CentroDTO centro) {
		val lista = centro.serviciosDTO.map[unServicio|this.servicioDtoAServicio(unServicio)]
		val servicios = new HashSet<Servicio>(lista)
		val cgp = new CGP(servicios, this.direccionDeCentroDTO(centro), "")
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

	static def HashSet<SucursalBanco> transformarDeJSONaClaseBanco(String listaDeBancosEnJson) {

		var HashSet<BancoJSON> bancosExternos
		var Gson gson = new Gson()
		var Type tipoListaDeBancosJson = new TypeToken<ArrayList<BancoJSON>>() {
		}.getType()
		bancosExternos = new HashSet<BancoJSON>(gson.fromJson(listaDeBancosEnJson, tipoListaDeBancosJson))
		return Sets.newHashSet(bancosExternos.map[unBancoExterno|pasarDeBancoJsonASucBanco(unBancoExterno)])
	}

	static def SucursalBanco pasarDeBancoJsonASucBanco(BancoJSON unBancoExterno) {
		var listaServicios = unBancoExterno.servicios.map[unServicio|servicioJSONAServicio(unServicio)]
		var servicios = new HashSet<Servicio>(listaServicios)
		return new SucursalBanco(servicios, direccionDeBanco(unBancoExterno),
			unBancoExterno.banco + "" + unBancoExterno.sucursal)
	}

	// Modelado de la direccion de BancoJSON a SucursalBanco
	static def Direccion direccionDeBanco(BancoJSON unBancoExterno) {
		var Point coordenadas = new Point(unBancoExterno.x, unBancoExterno.y)
		var direccion = new Direccion("", "", #["", ""], coordenadas, "", "",
			new Comuna("", new Polygon(#[new Point(0, 0), new Point(0, 0)])), "", "", "", "")
		return direccion
	}

	static def Horario horarioBancario() {
		var turnosDisponiblesBanco = new HashSet<Turno>
		var diasHabilesBanco = new HashSet<Dia>
		var turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.VIE)
		return new Horario(diasHabilesBanco, turnosDisponiblesBanco)

	}

	// Modelado del servicio
	static def Servicio servicioJSONAServicio(String servicioJSON) {
		var Servicio servicio = new Servicio(servicioJSON, horarioBancario())
		return servicio
	}

}
