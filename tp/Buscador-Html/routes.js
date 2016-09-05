buscadorApp.config(function ($stateProvider) {

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('verInfo', {
      url: "/poi/:nombre",
      templateUrl: "/poi.html",
      controller: "poiController as poiCtrl"
    })

});