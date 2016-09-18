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
import dependencias.Bootstrap
import usuarios.RepoUsuarios

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

		var Busqueda busquedaPois = new Busqueda
		var Administrador admin=new Administrador(busquedaPois)
		var Repositorio repo=Repositorio.instance
		var Bootstrap unBoots=new Bootstrap
		var RepoUsuarios repoUsuarios=RepoUsuarios.instance
		new(){
	
		
		repo.create(unBoots.obtenerCGPFlores)
		repo.create(unBoots.obtenerBanco)
		repo.create(unBoots.obtenerKiosco)
		repo.create(unBoots.obtenerParadaColectivo)
		busquedaPois.agregarOrigen(Repositorio.instance)
		}
	extension JSONUtils = new JSONUtils
	
	extension JSONPropertyUtils = new JSONPropertyUtils
	
	@Get('/pois/:crit')
	def Result buscar() {
			var criterio=crit.split("%20").fold("",[str1,str2|str1+ " "+ str2+ " "])
		response.contentType = ContentType.APPLICATION_JSON
		
			ok(busquedaPois.buscar(criterio,admin).toJson)
	}
	@Put('/pois/:poiId/like/:usuario')
	def Result like(){
		var PerfilDeUsuario perfil=repoUsuarios.search(usuario)
		perfil.favoritos.add(poiId.fromJson(Integer))
		repoUsuarios.update(perfil)
		ok('{ "status" : "OK" }');
	}
	def static void main(String[] args) {
		XTRest.start(PoiController, 8000)
	}
}

	