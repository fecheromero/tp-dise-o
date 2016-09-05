'use strict';

var app = angular.module('buscadorApp',['ui.router'])


/* Controllers */
function LocalComercial(_nombre,_direccion,_rubro,_icono){
	this.nombre=_nombre;
	this.direccion=_direccion;
	this.rubro=_rubro;
	this.icono=_icono;

};

function SucursalBanco(_nombre,_zona,_direccion,_rubro,_icono){
	this.nombre=_nombre;
	this.direccion=_direccion;
	this.rubro=_rubro;
	this.icono=_icono;
	this.zona=_zona;

};

function CGP(_nombre,_zona,_direccion,_servicios,_icono){
	this.nombre=_nombre;
	this.direccion=_direccion;
	this.servicios=_servicios;
	this.icono=_icono;
	this.zona=_zona;

};

function Colectivo(_nombre,_direccion,_icono){
	this.nombre=_nombre;
	this.direccion=_direccion;
	this.icono=_icono;

};

function tagearPoi(poi){
	return poi.nombre+" "+poi.direccion+" "+poi.horario+" ";
};
function filtrarPois(listaDePois,criterio){
	return listaDePois.filter(function (poi){
		return tagearPoi(poi).includes(criterio);
	});
};

var pois=[new Colectivo("linea7","843 y 892","parada de colectivo"),new LocalComercial("La continental","siempre viva 122","kiosco","kiosco")]

app.controller('buscadorCtrl', function () {
	/* scope */
	this.criterio ="saraza";
	this.resultado=pois;
	this.criterios=["algo"];
	var self=this;
	this.buscar =function() {
		this.resultado=pois.filter(function (poi){
			var unPoi=poi;
		return self.criterios.some(function (criterio){
			return tagearPoi(unPoi).includes(criterio);	
		})
	})};
	this.agregar =function() {
		if(!this.criterios.includes(self.criterio)){this.criterios.push(this.criterio);};
	
	};
	this.limpiar=function(){
		this.criterios=[];
		this.criterio="";
	};
});
app.controller('poiController', function ($stateParams, $state, TareasService) {
		

}
)


  
  
