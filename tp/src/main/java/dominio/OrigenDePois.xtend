package dominio

import dominio.pois.PuntoDeInteres
import java.util.List
import java.util.ArrayList

interface OrigenDePois {
	def List<PuntoDeInteres>buscar(String algo){}

}