app.config(function($stateProvider, $urlRouterProvider) {

	$urlRouterProvider.otherwise("/");

	$stateProvider

	.state('verResultados', {
		
		url : "/",
		templateUrl : "templates/resultados.html",
		controller : "buscadorCtrl as buscadorCtrl"
	})
	.state('verInfo', {
		url : "/:nombre",
		 template: '<ui-view/>',
	    controller : "poiController as poiCtrl"
	})
	.state('verInfo.LocalComercial',{
		url:"/localcomercial",
		templateUrl : "templates/local-comercial.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verInfo.SucursalBanco',{
		url:"banco",
		templateUrl : "templates/sucursal bancaria.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verInfo.CGP',{
		url:"/CGP",
		templateUrl : "templates/cgp.html",
		controller : "vistaController as vistaCtrl"
	})
	.state('verInfo.Colectivo',{
		url:"/colectivo",
		templateUrl : "templates/colectivo.html",
		controller : "vistaController as vistaCtrl"
	})
	
	.state('verBusqueda', {
		
		url : "/index",
		templateUrl : "index.html",
		controller : "loginCtrl as loginCtrl"
	})
	.state('verLogin', {
		
		url : "/",
		templateUrl : "template/login.html",
		controller : "loginCtrl as loginCtrl"
	})
})
