'use strict';

var app = angular.module('buscadorApp', [ 'ui.router' ])

/* Controllers */
function LocalComercial(_nombre, _direccion, _rubro) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.rubro = _rubro;

};
LocalComercial.prototype.icono = "local.jpg";

function SucursalBanco(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;

};
SucursalBanco.prototype.icono = "banco.jpg";

function CGP(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;

};
CGP.prototype.icono = "cgp.jpg";

function Colectivo(_nombre, _direccion) {
	this.nombre = _nombre;
	this.direccion = _direccion;

};
Colectivo.prototype.icono = "icono-colectivo.jpg";

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
		]


app.controller('buscadorCtrl', function($state) {
	/* scope */
	this.criterio = "saraza";
	this.resultado = pois;
	this.criterios = [ "algo" ];
	var self = this;
	this.buscar = function() {
		this.resultado = pois.filter(function(poi) {
			var unPoi = poi;
			return self.criterios.some(function(criterio) {
				return tagearPoi(unPoi).includes(criterio);
			})
		})
	};
	this.agregar = function() {
		if (!this.criterios.includes(self.criterio)) {
			this.criterios.push(this.criterio);
		};

	};
	this.limpiar = function() {
		this.criterios = [];
		this.criterio = "";
		this.resultado = [];
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