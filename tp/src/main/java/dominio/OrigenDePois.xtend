package dominio

import dominio.pois.PuntoDeInteres
import java.util.List

interface OrigenDePois {
	def List<PuntoDeInteres>buscar(String algo){}
}