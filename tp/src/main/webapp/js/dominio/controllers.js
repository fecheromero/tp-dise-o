'use strict';

var resultado2;
var poiCache;
var usuarioCache;
var criterios2=[];
app.controller('buscadorCtrl', function(poisService, $state, $timeout) {
	/* scope */
	var self = this;

	this.criterio = "";
	self.resultado = resultado2;
	this.criterios = criterios2;
	self.errors = [];
	self.usuario = usuarioCache;
	self.$timeout = $timeout;
	//self.unlike = "true";
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
		var crit=_.reduce(self.criterios, function(str1, str2) {
			return str1 + "SPC" + str2
		});
		$state.go("busqueda");	
		$state.reload();
		poisService.buscar(crit, function(response) {
			resultado2 = _.map(response.data, transformarAPoi);
			self.resultado=resultado2;
			$state.go("busqueda.verResultados");

		}, function() {
			notificarError(self)
		});
	};
	this.agregar = function() {
		if (!criterios2.includes(self.criterio)) {
			criterios2.push(this.criterio);

		}
		;

	};
	this.limpiar = function() {
		criterios2 = [];
		this.criterios=criterios2;
		this.criterio = "";
		resultado2 = [];
		self.resultado = resultado2;
		$state.go("busqueda");
	};
	this.like = function(poi) {
		poisService.like(self.usuario, poi.id, function() {
		
			self.favoritos();	
			self.buscar();
		}, notificarErrorPois);
			
	};
	this.disLike = function(poi) {
		poisService.disLike(self.usuario, poi.id, function() {
			
			self.favoritos();
			self.buscar();
			}, notificarErrorPois);
	
		
	};

});
app.controller('poiController', function(poisService,$stateParams, $state) {
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
		poisService.agregarReview(self.poi.id,self.usuario,self.puntaje,self.comentario,function(){
			$state.reload()
		},function() {
			notificarError(self)
		});
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

var mensajeDeError2=false;
app.controller('loginCtrl',function(poisService,$state) {
		this.usuario;
		this.clave;
		this.mensajeDeError=mensajeDeError2;
		var self = this;
		this.login = function() {
			poisService.verificarUsuario(self.usuario,self.clave,
				function(response){
				if(response.data.status=="OK"){
					mensajeDeError2=false;
					usuarioCache=self.usuario;
					$state.go("busqueda");
				}else{
					mensajeDeError2=true;
					$state.reload();
				}
			},function() {
				notificarError(self)
				})
		};
		});
