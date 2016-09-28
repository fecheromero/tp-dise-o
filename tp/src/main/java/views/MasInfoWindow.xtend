package views

import dominio.pois.PuntoDeInteres
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import java.util.List
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import java.awt.Color
import java.lang.reflect.Type
import org.uqbar.arena.widgets.Selector
import dominio.pois.Servicio

class MasInfoWindow extends TransactionalDialog<PuntoDeInteres> {
	static var List<ParParametrico> listaParametros
	static var PuntoDeInteres poi
	static var List<ParParametrico> listaParametrosCombos=#[]
	new(WindowOwner owner,PuntoDeInteres _poi, List<ParParametrico> _lista,List<ParParametrico>_listaCombo){
		super(owner,_poi)
		listaParametros=_lista
		poi=_poi
		listaParametrosCombos=_listaCombo
	}
	
	def defaultTitle() {
		"informacion"
	}
		override protected createFormPanel(Panel mainPanel) {
		this.title="Informacion"
		
		agregarPanelDePropiedad("icono","icono",mainPanel)
		listaParametros.forEach[propiedad|agregarPanelDePropiedad(propiedad.parametro,propiedad.descripcion,mainPanel)]
		listaParametrosCombos.forEach[propiedad| agregarCombo(propiedad.parametro,propiedad.descripcion,mainPanel)]
		}
		def protected agregarPanelDePropiedad(String label,String property,Panel contenedor){
			
			var Panel nuevoPanel=new Panel(contenedor)=>[
				layout=new HorizontalLayout
			 
			]
			new Label(nuevoPanel)=>[
				text=label.concat(":")
						foreground = Color.BLUE
			
			]
			new Label(nuevoPanel)=>[
				value<=> property
				

			]
		}
		def protected agregarCombo(String label,String property,Panel contenedor){
			var Panel nuevoPanel=new Panel(contenedor)=>[
			
				layout=new HorizontalLayout
					
				]
			new Label(nuevoPanel)=>[
				text=label
				foreground = Color.BLUE
				]			
			new Selector<Servicio>(nuevoPanel)=>[
				items<=>property
				allowNull=false
			]
		}
	
		
		
}