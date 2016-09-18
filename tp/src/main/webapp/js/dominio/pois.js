function LocalComercial(_nombre, _direccion, _rubro) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.rubro = _rubro;

};
LocalComercial.prototype.icono = "local.jpg";

function SucursalBanco(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;

};
SucursalBanco.prototype.icono = "banco.jpg";

function CGP(_nombre, _zona, _direccion, _servicios) {
	this.nombre = _nombre;
	this.direccion = _direccion;
	this.servicios = _servicios;
	this.zona = _zona;

};
CGP.prototype.icono = "cgp.jpg";

function Colectivo(_nombre, _direccion) {
	this.nombre = _nombre;
	this.direccion = _direccion;

};
Colectivo.prototype.icono = "icono-colectivo.jpg";

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