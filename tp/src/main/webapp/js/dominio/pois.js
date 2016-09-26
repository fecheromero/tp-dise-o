function LocalComercial(_nombre, _direccion, _rubro) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.rubro = _rubro;
	this.like="true";
	this.reviews=[];
	this.icono="images/Local.jpg";
};
//LocalComercial.prototype.icono = "images/Local.jpg";

function SucursalBanco(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;
	this.like="true";
	this.reviews=[];
	this.icono="images/banco.jpg";
};
//SucursalBanco.prototype.icono = "images/banco.jpg";

function CGP(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;
	this.like="true";
	this.reviews=[];
	this.icono="images/cgp.jpg";
};
//CGP.prototype.icono = "images/cgp.jpg";

function Colectivo(_nombre, _direccion) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.like="true";
	this.reviews=[];
	this.icono="images/icono-colectivo.jpg";
};
//Colectivo.prototype.icono = "images/icono-colectivo.jpg";

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