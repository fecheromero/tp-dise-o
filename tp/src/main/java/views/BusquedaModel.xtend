package views

import java.util.List
import dominio.pois.PuntoDeInteres
import java.util.ArrayList

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class BusquedaModel {
	val resultados=new ArrayList<PuntoDeInteres>
}