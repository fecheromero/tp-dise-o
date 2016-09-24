'use strict';

var resultado2;
app.controller('buscadorCtrl', function(poisService, $state, $timeout) {
	/* scope */
	var self = this;

	this.criterio = "";
	self.resultado = resultado2;
	this.criterios = [];
	self.errors = [];
	self.usuario = usuarioCache;
	self.$timeout = $timeout;
	self.unlike = "true";
	self.favoritosList = [];
	this.favoritos = function() {
		poisService.favoritos(self.usuario, function(response) {
			self.favoritosList = _.map(response.data, function(JsonNum) {
				return eval(JsonNum);
			});
		}, function() {
			notificarError(self)
		});
	};
	this.favoritos();

	function transformarAPoi(jsonPoi) {

		var punto = eval(jsonPoi.tipo + ".asPoi(jsonPoi)");
		punto.like = _.includes(self.favoritosList, punto.id)
		return punto;
	}
	;
	function notificarErrorPois(infoError) {
		notificarError(self, infoError);

	}

	this.buscar = function() {
		poisService.buscar(_.reduce(self.criterios, function(str1, str2) {
			return str1 + "SPC" + str2
		}), function(response) {
			resultado2 = _.map(response.data, transformarAPoi);
			$state.go("busqueda.verResultados");

		}, function() {
			notificarError(self)
		});
	};
	this.agregar = function() {
		if (!this.criterios.includes(self.criterio)) {
			this.criterios.push(this.criterio);
		}
		;

	};
	this.limpiar = function() {
		this.criterios = [];
		this.criterio = "";
		resultado2 = [];
		self.resultado = [];
		$state.go("busqueda");
	};
	this.like = function(poi) {
		poisService.like(self.usuario, poi.id, function() {
			self.favoritos();
			$state.reload();
		}, notificarErrorPois);
		$state.reload();
	};
	this.disLike = function(poi) {
		poisService.disLike(self.usuario, poi.id, function() {
			self.favoritos();
			$state.reload();
		}, notificarErrorPois);
		$state.reload();
	};

});
var poiCache;
app.controller('poiController', function($stateParams, $state) {
	this.usuario=usuarioCache;
	this.puntaje=0;
	this.comentario="";
	var self=this;
	
	poiCache = _.find(resultado2, {
		id : parseInt($stateParams.id)
	});
	this.poi = poiCache;

	if (poiCache instanceof LocalComercial) {
		$state.go("busqueda.verInfo.LocalComercial");

	}
	if (poiCache instanceof Colectivo) {
		$state.go("busqueda.verInfo.Colectivo");
	}
	if (poiCache instanceof CGP) {
		$state.go("busqueda.verInfo.CGP");
	}
	if (poiCache instanceof SucursalBanco) {
		$state.go("busqueda.verInfo.SucursalBanco");
	};
	this.tieneReview=_.some(self.poi.reviews,{
		usuario:self.usuario
	});
	
	this.enviar=function(){
		poisService.agregarReview(self.poi.id,self.puntaje,self.comentario,function(){
			$state.reload()
		}, notificarErrorPois);
	};
	this.volver = function() {
		$state.go("busqueda.verResultados")
	};
});
/*
app.controller('vistaController', function($state) {
	this.poi=poiCache;
	this.volver = function() {
		$state.go("busqueda.verResultados")
	};
	

});
*/
// login

function Usuario(usuario, clave) {
	return {
		usuario : usuario,
		clave : clave
	};
}

var usuarios = [ new Usuario("admin", "1234") ];
var usuarioCache;
app.controller('loginCtrl',function($state) {
		this.usuario;
		this.clave;
		var self = this;
		this.login = function() {
		var usuarioEncontrado = _.find(usuarios, {
			usuario : this.usuario
			});
			if (usuarioEncontrado) {
				if (usuarioEncontrado.clave == this.clave) {
					usuarioCache=self.usuario;
					$state.go("busqueda");
				} else {
					this.clave = "";
					this.resultadoLogin = "La clave ingresada es incorrecta (intente con 1234).";
					$state.go("verLoginIncorrecto")
				}
			} else {
				this.usuario = "";
			this.clave = "";
			this.resultadoLogin = "El usuario ingresado no existe (intente con juanPerez).";
				$state.go("verLoginIncorrecto")
			}
		};
		});
