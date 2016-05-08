package interfazAServiciosExternos

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonValue
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import dominio.pois.SucursalBanco
import com.google.common.collect.Lists
import java.util.HashSet
import dominio.pois.Servicio
import com.google.common.collect.Sets
import dominio.pois.Direccion
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import dominio.pois.Comuna
import dominio.tiempo.Turno
import org.joda.time.LocalTime
import dominio.tiempo.Dia
import dominio.tiempo.Horario

@Accessors
public class AdapterJson extends ServicioExterno {
	String listaDeBancosEnJson
	new(String listaDeBancosEnJson){
		this.listaDeBancosEnJson = listaDeBancosEnJson
	}
	override ArrayList<SucursalBanco> buscar(String zona) {
		return this.transformarDeJSONaClaseBanco()
	}

	def ArrayList<SucursalBanco> transformarDeJSONaClaseBanco() {

		var JsonArray listaJson = Json.parse(listaDeBancosEnJson).asArray()
		return Lists.newArrayList(listaJson.map[unBancoJson|convertirASucursalBanco(unBancoJson)])

	}

	def SucursalBanco convertirASucursalBanco(JsonValue unBancoJson) {
		var String banco = unBancoJson.asObject().get("banco").asString()
		var double x = unBancoJson.asObject().get("x").asDouble()
		var double y = unBancoJson.asObject().get("y").asDouble()
		var String sucursal = unBancoJson.asObject().get("sucursal").asString()
		// var String gerente = unBancoJson.asObject().get("gerente").asString()
		var JsonArray serviciosJson = unBancoJson.asObject().get("servicios").asArray()
		var HashSet<Servicio> serviciosBanco = Sets.newHashSet(serviciosJson.map [ unServicioJson |
			convertirAServicioBanco(unServicioJson)
		])
		return new SucursalBanco(serviciosBanco, direccionDeBanco(x, y), banco + " " + sucursal)
	}

	// Modelado de la direccion de BancoJSON a SucursalBanco
	def Direccion direccionDeBanco(double x, double y) {
		var Point coordenadas = new Point(x, y)
		var direccion = new Direccion("", "", #["", ""], coordenadas, "", "",
			new Comuna("", new Polygon(#[new Point(0, 0), new Point(0, 0)])), "", "", "", "")
		return direccion
	}

	// Modelado del servicio
	def Servicio convertirAServicioBanco(JsonValue unServicioJson) {
		var String servicioJSON = unServicioJson.asString()
		var Servicio servicio = new Servicio(servicioJSON, horarioBancario())
		return servicio
	}

	//Método que me devuelve el Horario Bancario
	static def Horario horarioBancario() {
		var turnosDisponiblesBanco = new HashSet<Turno>
		var diasHabilesBanco = new HashSet<Dia>
		var turnoBanco = new Turno(new LocalTime(10, 0), new LocalTime(15, 0))
		turnosDisponiblesBanco.add(turnoBanco)
		diasHabilesBanco.addAll(Dia.LUN, Dia.MAR, Dia.MIE, Dia.JUE, Dia.VIE)
		return new Horario(diasHabilesBanco, turnosDisponiblesBanco)

	}

}
