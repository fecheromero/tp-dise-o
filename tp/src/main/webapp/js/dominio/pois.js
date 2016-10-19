function Poi(){
	
	this.estaCerca= function(punto){
		return this.direccion.coordenadasS.distance(punto) < this.distancia_MAXIMA
	}
}

var poi=new Poi();

function LocalComercial(_nombre, _direccion, _rubro) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.rubro = _rubro;
	this.like="true";
	this.reviews=[];
	this.icono="images/Local.jpg";
};
LocalComercial.prototype=poi;

function SucursalBanco(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;
	this.like="true";
	this.reviews=[];
	this.icono="images/banco.jpg";
};
SucursalBanco.prototype=poi;

function CGP(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;
	this.like="true";
	this.reviews=[];
	this.icono="images/cgp.jpg";
};
CGP.prototype=poi;

function Colectivo(_nombre, _direccion) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.like="true";
	this.reviews=[];
	this.icono="images/icono-colectivo.jpg";
};
Colectivo.prototype=poi;

CGP.asPoi= function(jsonPoi){

  return angular.extend(new CGP(), jsonPoi);
}
LocalComercial.asPoi= function(jsonPoi){

  return angular.extend(new LocalComercial(), jsonPoi);
};
Colectivo.asPoi= function(jsonPoi){

  return angular.extend(new Colectivo(), jsonPoi);
};

SucursalBanco.asPoi= function(jsonPoi){

  return angular.extend(new SucursalBanco(), jsonPoi);
};

function asPoint(palabra){
	this.cadena= palabra.split(" ");
	this.y=cadena[3];
	this.x=sinComa(cadena[1]);
	return new Point(parseInt(this.x),parseInt(this.y))
}
function sinComa(palabra){
	this.tamaño=(palabra.length)-1;
	return palabra.substring(0,tamaño)
}
