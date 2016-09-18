'use strict';


var resultado2;
app.controller('buscadorCtrl', function(poisService,$state,$timeout) {
	/* scope */
	var self = this;

	this.criterio="";
	self.resultado=resultado2;
	this.criterios=[];
	self.errors=[];
	self.usuario="admin";
	self.$timeout=$timeout;
	self.unlike="true";
	self.favoritosList=[];
		this.favoritos=function(){
		poisService.favoritos(self.usuario,function(response){
			self.favoritosList=_.map(response.data,function(JsonNum){
				return eval(JsonNum);
			});
		},function(){
			notificarError(self)});
	};
	this.favoritos();


function transformarAPoi(jsonPoi){

	  var punto=eval(jsonPoi.tipo+".asPoi(jsonPoi)");
	  punto.like=_.includes(self.favoritosList,punto.id)
	  return punto;
};
function notificarErrorPois(infoError){
notificarError(self,infoError);

}

	this.buscar=function(){
		poisService.buscar(_.reduce(self.criterios,function (str1,str2){
			return str1 + "SPC" + str2
		}
			),function(response){
			resultado2=_.map(response.data,transformarAPoi);
			$state.reload();
	
		},function() {
    	notificarError(self)
    });
	};
	this.agregar = function() {
		if (!this.criterios.includes(self.criterio)) {
			this.criterios.push(this.criterio);
		};

	};
	this.limpiar = function() {
		this.criterios = [];
		this.criterio = "";
		resultado2=[];
		self.resultado=[];
		$state.reload();
	};
	this.like=function(poi){
		poisService.like(self.usuario,poi.id,function(){
			self.favoritos();
			self.buscar();
		},notificarErrorPois);
		$state.reload();
	};
	this.disLike=function(poi){
		poisService.disLike(self.usuario,poi.id,function(){
			self.favoritos();
			self.buscar();
		},notificarErrorPois);
		$state.reload();
	};


});
var poi;
app.controller('poiController', function($stateParams, $state) {

	poi = $stateParams
	
	if (poi instanceof LocalComercial){
		$state.go("verInfo.LocalComercial");
		
	}
	if (poi instanceof Colectivo){
		$state.go("verInfo.Colectivo");
	}
	if (poi instanceof CGP){
		$state.go("verInfo.CGP");
	}
	if (poi instanceof SucursalBanco){
		$state.go("verInfo.SucursalBanco");
	}

});
app.controller('vistaController', function($state) {
	this.poi=poi;
	
	this.volver = function() {
		$state.go("verResultados")
	};
	
});


function Usuario (usuario, clave) {
		return {usuario: usuario, clave: clave};
	};

app.controller('loginCtrl', function($state) {		
	

});


