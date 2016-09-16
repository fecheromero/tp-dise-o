app.service('poisService', function ($http) {

  this.buscar = function (criterio,callback, errorHandler) {
    $http.get('/pois/'+criterio).then(callback, errorHandler);
  };

});


