'use strict';

var app = angular.module('buscadorApp', [])

/* Controllers */
function Poi(_nombre,_direccion,_horario,_icono){
	this.nombre=_nombre;
	this.direccion=_direccion;
	this.horario=_horario;
	this.icono=_icono;

};
function tagearPoi(poi){
	return poi.nombre+" "+poi.direccion+" "+poi.horario+" "+poi.icono ;
};
function filtrarPois(listaDePois,criterio){
	return listaDePois.filter(function (poi){
		return tagearPoi(poi).includes(criterio);
	});
};

var pois=[new Poi("114","843 y 892","24/7","parada de colectivo"),new Poi("Don Pepito","siempre viva 1212","11:00-19:00","negocio"),]

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



  
  
