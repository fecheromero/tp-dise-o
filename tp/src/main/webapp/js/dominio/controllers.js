'use strict';


var resultado2;
function notificarError(){};
function transformarAPoi(jsonPoi){

	  return eval(jsonPoi.tipo+".asPoi(jsonPoi)");
	  
};
app.controller('buscadorCtrl', function(poisService,$state) {
	/* scope */
	this.criterio="";
	this.resultado=resultado2;
	this.criterios=[];
	var self = this;

	this.buscar=function(){
		poisService.buscar(_.reduce(self.criterios,function (str1,str2){
			return str1 + " " + str2 + " "
		}
			),function(response){
			resultado2=_.map(response.data,transformarAPoi);
			$state.reload();
	
		},notificarError);
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
});
var poi;
app.controller('poiController', function($stateParams, $state) {
	poi = _.find(pois,function(aux){return aux.nombre== $stateParams.nombre;});
	
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