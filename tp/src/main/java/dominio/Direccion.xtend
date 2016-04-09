package dominio

import java.util.ArrayList
import org.uqbar.geodds.Point

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
	
	def Point getCoordenadas() {
		
		return coordenadas
		
	}
	
	def getComuna() {
		return comuna
	}
	
		 
}