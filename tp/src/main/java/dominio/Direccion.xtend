package dominio

import java.util.ArrayList
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
	def String listaDeTags(){
		var String lista=""
		lista.concat(this.callePrincipal).concat(this.numero).concat(this.entre.get(1)).concat(this.entre.get(2)).concat(this.localidad).concat(this.provincia).concat(this.comuna.listaDeTags()).concat(this.codigoPostal).concat(this.piso).concat(this.departamento).concat(this.unidad)
	}
	def Point getCoordenadas() {
		
		return coordenadas
		
	}
	
	def getComuna() {
		return comuna
	}
	
		 
}