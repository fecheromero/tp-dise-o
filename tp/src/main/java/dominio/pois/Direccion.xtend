package dominio.pois

import dependencias.Tageador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import dependencias.Validable
import dependencias.Validator
import org.uqbar.commons.utils.Observable
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonIgnore

@Accessors

@JsonIgnoreProperties(ignoreUnknown = true)
class Direccion implements Validator {
	@Validable
	String callePrincipal
	@Validable
	String numero
	@Validable
	String[] entre
	@Validable
	@JsonIgnore
	Point coordenadas
	@Validable
	String localidad
	@Validable
	String provincia
	@Validable
	Comuna comuna
	@Validable
	String codigoPostal
	String piso
	String departamento
	String unidad
	String direccionS
	@JsonIgnore
	Tageador tag =Tageador.getInstance

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
		direccionS=callePrincipal.concat(" ").concat(numero)
	}

	def String listaDeTags() {
		tag.tagear(this).concat(tag.tagear(comuna)).concat(entre.get(0)).concat(" ").concat(entre.get(1))
	// lista.concat(#[this.callePrincipal,this.numero,this.entre.get(0),this.entre.get(1),this.localidad,this.provincia,this.comuna.listaDeTags(),this.codigoPostal,this.piso,this.departamento,this.unidad].fold("",[palabra1,palabra2 | palabra1.concat(" ").concat(palabra2)]))
	}

	/*def validate() {

		if(Direccion.declaredFields.exists [ field |
			field.accessible = true
			field.get(this) == null
		]) throw new NoValidoException("La direccion no es valida")
	}*/

}
