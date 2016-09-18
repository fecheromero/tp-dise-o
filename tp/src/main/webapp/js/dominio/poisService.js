app.service('poisService', function ($http) {

  this.buscar = function (criterio,callback, errorHandler) {
    $http.get('/pois/'+criterio).then(callback, errorHandler);
  };
  this.like=function(usuario,poi,callback,errorHandler){
  	$http.put('pois/poi/like/'+usuario).then(callback,errorHandler);
  };
  this.unlike=function(usuario,poi,callback,errorHandler){
  	$http.put('pois/poi/unlike/'+usuario).then(callback,errorHandler);
  };
});


