package controller

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotations.*
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import dependencias.JSONPropertyUtils
import dominio.Busqueda
import dominio.Repositorio
import dominio.PerfilesDeUsuario.PerfilDeUsuario
import dominio.PerfilesDeUsuario.Administrador
import dominio.OrigenDePois
import dominio.locales.LocalComercial
import dominio.tiempo.Horario
import dominio.tiempo.Dia
import java.util.HashSet
import dominio.tiempo.Turno
import org.joda.time.LocalTime
import java.util.Set
import dominio.pois.Servicio
import dominio.pois.CGP
import dominio.pois.Direccion
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import dominio.pois.Comuna
import com.fasterxml.jackson.annotation.PropertyAccessor
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
/*
class AnotherJSONUtils{
	ObjectMapper mapper = new ObjectMapper().setVisibility(PropertyAccessor.FIELD, Visibility.ANY)
	
	def toJson(Object obj) {
		mapper.writeValueAsString(obj)
	}
	
	def <T> fromJson(String json, Class<T> expectedType) {
		mapper.readValue(json, expectedType)
	}
	
} */
@Controller
class PoiController {
	extension JSONUtils = new JSONUtils
	
	extension JSONPropertyUtils = new JSONPropertyUtils
	
	@Get('/pois/:crit')
	def Result buscar() {
		var criterio=crit
		var Busqueda busquedaPois = new Busqueda
		var Administrador admin=new Administrador(busquedaPois)
		var Repositorio repo=Repositorio.instance
		var HashSet<Turno>	unosTurnos=new HashSet<Turno>
		unosTurnos.add(new Turno(new LocalTime(0,10),new LocalTime(2,4)))
		var HashSet<Dia>unosDias=new HashSet<Dia>
		unosDias.add(Dia.LUN)
		var Horario unHorario=new Horario(unosDias,unosTurnos)
		var  servicios = new HashSet<Servicio>
		servicios.add(new Servicio("asistencia Social",unHorario))
		var almagro = new Comuna("once",new Polygon(#[new Point(0, 0), new Point(0, 5), new Point(5, 5), new Point(5, 0)]))		
	
		var unCGP = new CGP(servicios,new Direccion("calle sarmiento", "2142", #["san Martin", "Belgrano"], new Point(4, 6), "bs as","Buenos Aires", almagro, "1881", "", "", ""), "Centro de gestion y participacion")
		
		
		repo.create(unCGP)
		busquedaPois.agregarOrigen(Repositorio.instance)
		
			ok(busquedaPois.buscar(criterio,admin).toJson)
	}
	def static void main(String[] args) {
		XTRest.start(PoiController, 8000)
	}
}

	