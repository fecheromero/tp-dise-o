
var loginApp = angular.module('loginApp', [ 'ui.router' ]);


function Usuario (usuario, clave) {
		return {usuario: usuario, clave: clave};
	}
	
var usuarios = [
		new Usuario("juanPerez", "1234")
	];
		


loginApp.controller('loginCtrl', function($state) {		
	this.login = function () {
		var usuarioEncontrado = _.find(self.usuarios, { usuario: this.usuario });
		if (usuarioEncontrado){
			if (usuarioEncontrado.clave == this.clave){
				$state.go("verBusqueda");
			}else{
				this.clave = "";
				this.resultadoLogin = "La clave ingresada es incorrecta (intente con 1234).";>
				$state.go("verLoginIncorrecto")	
			}
		}else{
			this.usuario = "";
			this.clave = "";
			this.resultadoLogin = "El usuario ingresado no existe (intente con juanPerez).";
			$state.go("verLoginIncorrecto")
		}
	};

};