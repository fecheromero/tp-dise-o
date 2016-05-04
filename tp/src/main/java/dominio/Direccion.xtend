package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.NoValidoException
import dependencias.*
import org.uqbar.geodds.Point

@Accessors
class Direccion {
	String callePrincipal
	String numero
	String[] entre
	Point coordenadas
	String localidad
	String provincia
	Comuna comuna
	String codigoPostal
	String piso
	String departamento
	String unidad
	Tageador tag = new Tageador()

	new(String callePrincipal, String numero, String[] entre, Point coordenadas, String localidad, String provincia,
		Comuna comuna, String codigoPostal, String piso, String departamento, String unidad) {
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

	def String listaDeTags() {
		tag.tagear(this).concat(tag.tagear(comuna)).concat(entre.get(0)).concat(" ").concat(entre.get(1))
	// lista.concat(#[this.callePrincipal,this.numero,this.entre.get(0),this.entre.get(1),this.localidad,this.provincia,this.comuna.listaDeTags(),this.codigoPostal,this.piso,this.departamento,this.unidad].fold("",[palabra1,palabra2 | palabra1.concat(" ").concat(palabra2)]))
	}

	def validate() {

		if(Direccion.declaredFields.exists [ field |
			field.accessible = true
			field.get(this) == null
		]) throw new NoValidoException("La direccion no es valida")
	}

}
