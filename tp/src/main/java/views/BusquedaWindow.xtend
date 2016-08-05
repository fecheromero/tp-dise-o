package views

import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import dominio.pois.PuntoDeInteres
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BusquedaWindow extends MainWindow<BusquedaModel>{
	
	new() {
		super(new BusquedaModel)
	
	}
	 override createContents(Panel mainPanel){
		this.title="Buscador"
		 val panelPrincipal=new Panel(mainPanel)=>[
		 	layout=new ColumnLayout(2)
		 	]
		 	val panelDerecho=new Panel(panelPrincipal)
		 		new Label(panelDerecho).text="Criterio de busqueda"
		
		 	val  panelIzquierdo=new Panel(panelPrincipal)=>[
		 		layout=new HorizontalLayout]
		 		new Button(panelIzquierdo).caption = "Agregar"
		 		
		 		new Button(panelIzquierdo).caption = "Buscar"
		 	
		 val panelInferior=new Panel(panelPrincipal)
		 val grilla=new Table<PuntoDeInteres>(panelInferior, PuntoDeInteres)=>[
		 	items<=>"resultados"
			 ]
	}
	
		def static main(String[] args) {
		new BusquedaWindow().startApplication
	}
	}
	