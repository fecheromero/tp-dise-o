package dominio.pois

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import dependencias.Tageador
import dependencias.Validable
import dependencias.Validator
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Converter
import javax.persistence.Convert
import dependencias.PointConverter
import javax.persistence.Transient

@Accessors
@Entity
@JsonIgnoreProperties(ignoreUnknown = true)
class Direccion implements Validator {
	@Id
	@GeneratedValue
	int Id
	@Column(length=100)
	@Validable
	String callePrincipal
	@Validable
	@Column(length=100)
	String numero
	@Validable	
	@Column()
	String[] entre
	@Validable
	@JsonIgnore
	@Column()
	@Convert(converter=PointConverter)
	Point coordenadas
	@Validable
	
	@Column(length=100)
	String localidad
	@Validable
	
	@Column(length=100)
	String provincia
	@Validable
	
	@ManyToOne()
	Comuna comuna
	@Validable
	@Column(length=100)
	String codigoPostal
	
	@Column(length=100)
	String piso
	
	@Column(length=100)
	String departamento
	
	@Column(length=100)
	String unidad
	
	@Column(length=100)
	String direccionS
	
	@Column(length=100)
	String coordenadasS
	@Transient
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
		coordenadasS=coordenadas.toString
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
