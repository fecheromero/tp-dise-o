'use strict';

function tagearPoi(poi) {
	return poi.nombre + " " + poi.direccion + " " + poi.horario + " ";
};
function filtrarPois(listaDePois, criterio) {
	return listaDePois.filter(function(poi) {
		return tagearPoi(poi).includes(criterio);
	});
};


var pois = [ new Colectivo("linea7", "843 y 892"),
		new LocalComercial("La continental", "siempre viva 122", "Pizzeria"),
		new SucursalBanco("BBVA","Flores y Parque Chacabuco","al fondo a la derecha",["Atencion al cliente","Deposito"]),
		new CGP("CGP 7","Flores y Parque Chacabuco","Av. Rivadavia 2365.54",["Rentas","Registro Civil"])
		];

var resultado2;
function notificarError(){};
function transformarAPoi(jsonPoi){
	return  CGP.asPOI(jsonPoi);
};
app.controller('buscadorCtrl', function(poisService,$state) {
	/* scope */
	this.criterio="";
	this.resultado=resultado2;
	this.criterios=[];
	var self = this;
	/*this.buscar = function() {
		resultado2= pois.filter(function(poi) {
			var unPoi = poi;
			return self.criterios.some(function(criterio) {
				return tagearPoi(unPoi).includes(criterio);
			})
		})
		$state.reload();
	};*/
	this.buscar=function(){
		poisService.buscar(criterio,function(response){
			resultado2=_.map(response.data,transformarAPoi);
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
		resultado = [];
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