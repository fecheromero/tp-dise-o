app.config(function($stateProvider, $urlRouterProvider) {

	$urlRouterProvider.otherwise("/");

	$stateProvider

	.state('verResultados', {
		
		url : "/",
		templateUrl : "resultados.html",
		controller : "buscadorCtrl as buscadorCtrl"
	})
	.state('verInfo', {
		url : "/:nombre",
		 template: '<ui-view/>',
	    controller : "poiController as poiCtrl"
	})
	.state('verInfo.LocalComercial',{
		url:"/localcomercial",
		templateUrl : "local-comercial.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verInfo.SucursalBanco',{
		url:"/banco",
		templateUrl : "sucursal bancaria.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verInfo.CGP',{
		url:"/CGP",
		templateUrl : "cgp.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verInfo.Colectivo',{
		url:"/colectivo",
		templateUrl : "colectivo.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verBusqueda', {
		
		url : "/",
		templateUrl : "index.html",
		controller : "buscadorCtrl as buscadorCtrl"
	})

})
