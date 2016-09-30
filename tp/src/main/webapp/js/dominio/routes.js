app.config(function($stateProvider, $urlRouterProvider) {

	$urlRouterProvider.otherwise("/");
	 return $stateProvider
	

	.state('login',{
		url:"/",
		templateUrl:"templates/login.html",
		controller:"loginCtrl as loginCtrl"
	})	
	.state('busqueda',{
		url:"/busqueda",
		templateUrl:"templates/busqueda.html",
		controller:"buscadorCtrl as buscadorCtrl"
		resolve: {
			favoritosList : function() {
		poisService.favoritos(self.usuario, function(response) {
			self.favoritosList = _.map(response.data, function(JsonNum) {
				return eval(JsonNum);
			});
		}, function() {
			notificarError(self)
		});
	};
		}
	})
	.state('busqueda.verResultados', {
		
		url : "/resultados",
		templateUrl : "templates/resultados.html",
		controller : "buscadorCtrl as buscadorCtrl"
	})
	.state('busqueda.verInfo',{
		url : "/:id",
		 templateUrl: "templates/poi.html",
	    controller : "poiController as poiCtrl"
	})
	.state('busqueda.verInfo.LocalComercial',{
		url:"/localcomercial",
		templateUrl : "templates/local-comercial.html",
		controller : "poiController as poiCtrl"
	})
	.state('busqueda.verInfo.SucursalBanco',{
		url:"/banco",
		templateUrl : "templates/sucursal bancaria.html",
		controller : "poiController as poiCtrl"
	})
	.state('busqueda.verInfo.CGP',{
		url:"/CGP",
		templateUrl : "templates/cgp.html",
		controller : "poiController as poiCtrl"
	})
	.state('busqueda.verInfo.Colectivo',{
		url:"/colectivo",
		templateUrl : "templates/colectivo.html",
		controller : "poiController as poiCtrl"
	})
	
})	
	
	
/*	.state('verResultados', {
		
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
		url:"/banco",
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
		
		url : "/busqueda",
		templateUrl : "busqueda.html",
		controller : "loginCtrl as loginCtrl"
	})
	.state('verLogin', {
		
		url : "/login",
		templateUrl : "login.html",
		controller : "loginCtrl as loginCtrl"
	})
})
*/
