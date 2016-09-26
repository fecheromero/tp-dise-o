app.service('poisService', function ($http) {

  this.buscar = function (criterio,callback, errorHandler) {
    $http.get('/pois/busqueda/'+criterio).then(callback, errorHandler);
  };
  this.like=function(usuario,poi,callback,errorHandler){
  	$http.put('/pois/'+poi+'/like/'+usuario).then(callback,errorHandler);
  };
  this.disLike=function(usuario,poi,callback,errorHandler){
  	$http.put('/pois/'+poi+'/disLike/'+usuario).then(callback,errorHandler);
  };

  this.favoritos=function(usuario,callback,errorHandler){
  	$http.get('/pois/favoritos/'+usuario).then(callback,errorHandler);
  };
  this.agregarReview=function(poi,usuario,puntaje,comentario,callback,errorHandler){
	$http.put('/pois/'+poi+'/'+usuario+'/'+puntaje+'/'+comentario).then(callback,errorHandler);  
  };
  this.verificarUsuario= function(usuario,psw,callback,errorHandler){
	  $http.put('/'+usuario+'/'+psw).then(callback,errorHandler);
  };
});


