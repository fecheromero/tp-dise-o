package views

import java.util.List
import dominio.pois.PuntoDeInteres
import java.util.ArrayList

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import dominio.Busqueda
import org.uqbar.commons.utils.ApplicationContext
import dominio.PerfilesDeUsuario.Consulta
import observer.Accion

@Observable
@Accessors
class BusquedaModel {
	var String criterio=""
	var Busqueda repo=ApplicationContext.instance.getSingleton(typeof(Busqueda)) as Busqueda
	var List<PuntoDeInteres> resultados
	var PuntoDeInteres poiSeleccionado
	def void search(){
		resultados=repo.buscar(criterio,new Consulta("consulta",repo,new ArrayList<Accion>))
	}
	
}