package dominio


import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Direccion {
	
	String callePrincipal
	String numero
	String[] entre
	Point coordenadas
	String localidad
	String provincia
	Comuna comuna
	String  codigoPostal
	String piso
	String departamento
	String unidad
	
	new(String callePrincipal, String numero, String[] entre, Point coordenadas, String localidad, String provincia, Comuna comuna, String codigoPostal, String piso, String departamento, String unidad){
		this.callePrincipal = callePrincipal
		this.numero = numero
		this.entre = entre
		this.coordenadas = coordenadas
		this.localidad = localidad
		this.provincia = provincia
		this.comuna = comuna
		this.codigoPostal = codigoPostal
		this.piso = piso
		this.departamento = departamento
		this.unidad = unidad
	}
	
	def String listaDeTags(){
		var String lista=""
		lista.concat(#[this.callePrincipal,this.numero,this.entre.get(0),this.entre.get(1),this.localidad,this.provincia,this.comuna.listaDeTags(),this.codigoPostal,this.piso,this.departamento,this.unidad].fold("",[palabra1,palabra2 | palabra1.concat(" ").concat(palabra2)]))
	}

	
		 
}