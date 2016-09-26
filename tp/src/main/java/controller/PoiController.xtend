package controller

import dependencias.Bootstrap
import dependencias.JSONPropertyUtils
import dominio.Busqueda
import dominio.PerfilesDeUsuario.Administrador
import dominio.PerfilesDeUsuario.Consulta
import dominio.PerfilesDeUsuario.PerfilDeUsuario
import dominio.Repositorio
import java.util.ArrayList
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import usuarios.RepoUsuarios
import com.eclipsesource.json.Json
import dominio.pois.Review
import org.uqbar.xtrest.api.annotation.Post
import dominio.pois.PuntoDeInteres

/*
 * class AnotherJSONUtils{
 * 	ObjectMapper mapper = new ObjectMapper().setVisibility(PropertyAccessor.FIELD, Visibility.ANY)
 * 	
 * 	def toJson(Object obj) {
 * 		mapper.writeValueAsString(obj)
 * 	}
 * 	
 * 	def <T> fromJson(String json, Class<T> expectedType) {
 * 		mapper.readValue(json, expectedType)
 * 	}
 * 	
 } */
@Controller
class PoiController {

	var Busqueda busquedaPois = new Busqueda
	var Administrador admin = new Administrador(busquedaPois)
	var Repositorio repo = Repositorio.instance
	var Bootstrap unBoots = new Bootstrap
	var RepoUsuarios repoUsuarios = RepoUsuarios.instance

	new() {

		repo.create(unBoots.obtenerCGPFlores)
		repo.create(unBoots.obtenerBanco)
		repo.create(unBoots.obtenerKiosco)
		repo.create(unBoots.obtenerParadaColectivo)
		busquedaPois.agregarOrigen(Repositorio.instance)

		repoUsuarios.create(new Consulta("admin", "12345", busquedaPois, new ArrayList()))
	}

	extension JSONUtils = new JSONUtils

	extension JSONPropertyUtils = new JSONPropertyUtils

	@Get('/pois/busqueda/:crit')
	def Result buscar() {
		var criterio = crit.split("SPC").fold("", [str1, str2|str1.concat(" ").concat(str2).concat(" ")])
		response.contentType = ContentType.APPLICATION_JSON

		ok(busquedaPois.buscar(criterio, admin).toJson)
	}

	@Put('/pois/:poiId/like/:usuario')
	def Result like() {
		try {
			var PerfilDeUsuario perfil = repoUsuarios.search(usuario)
			perfil.favoritos.add(Integer.parseInt(poiId))
			repoUsuarios.update(perfil)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put('/pois/:poiId/disLike/:usuario')
	def Result disLike() {
		try {
			var PerfilDeUsuario perfil = repoUsuarios.search(usuario)
			perfil.favoritos.remove(Integer.parseInt(poiId))
			repoUsuarios.update(perfil)
			ok('{ "status" : "OK" }')
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get('/pois/favoritos/:usuario')
	def Result favoritos() {
		try {
			var PerfilDeUsuario usu = repoUsuarios.search(usuario)
			response.contentType = ContentType.APPLICATION_JSON
			ok(usu.favoritos.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	@Put('/pois/:poiId/:usuario/:puntaje/:comentario')
	def Result agregarReview(){
		try {
			var PuntoDeInteres poi=repo.searchBynd(Integer.parseInt(poiId))
			var Review review = new Review(usuario,Integer.parseInt(puntaje),comentario)
			poi.agregarReview(review)
			ok('{ "status" : "OK" }')
			
		} catch (Exception e) {
			badRequest(e.message)
		}
		
	}
	@Put('/:usuario/:pw')
	def Result verificarUsuario(){
		try {
			var PerfilDeUsuario user = repoUsuarios.search(usuario)
			if(user.contraseña==pw){
				ok('{ "status" : "OK" }')
			}else{ok('{ "status" : "ERROR"}')}
		} catch (Exception e){
			ok('{ "status" : "ERROR"}')
		}
	}
	
	def static void main(String[] args) {
		XTRest.start(PoiController, 8000)
	}
}
