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
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column

class BusquedaWindow extends SimpleWindow<BusquedaModel>{
	
	
	new(WindowOwner parent) {
		super(parent,new BusquedaModel)
		
	
	}
		override def createMainTemplate(Panel mainPanel) {
		title = "Buscador de Pois"
		taskDescription = "Ingrese los parámetros de búsqueda"

		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		}

	
	 override createFormPanel(Panel mainPanel){
		this.title="Buscador"
		 val panelPrincipal=new Panel(mainPanel)=>[
		 	layout=new ColumnLayout(2)
		 	]
		 	 var Panel panelIzquierdo=new Panel(panelPrincipal)
		 		new Label(panelIzquierdo).text="Criterio de busqueda"
		 		new TextBox(panelIzquierdo)=>[
		 			value<=>"criterio"
		 		]
	
		 	val  panelDerecho=new Panel(panelPrincipal)=>[
		 		layout=new HorizontalLayout]
		 		new Button(panelDerecho)=>[
		 		caption = "Agregar"
		 		onClick([|])
		 		disableOnError
		 		]
		 		new Button(panelDerecho)=>[
		 			caption = "Buscar"
		 			onClick([|modelObject.search
		 			])
			setAsDefault
			disableOnError
		 	]
		 
	}
	def void describeResultsGrid(Table<PuntoDeInteres> table) {
		new Column<PuntoDeInteres>(table) => [
			title = "Nombre"
			fixedSize = 200
			bindContentsToProperty("nombre")
		]
			new Column<PuntoDeInteres>(table) => [
			title = "Direccion"
			fixedSize = 200
			bindContentsToProperty("direccion.direccionS")
		]
		}
	def protected createResultsGrid(Panel mainPanel) {
		val table = new Table<PuntoDeInteres>(mainPanel, typeof(PuntoDeInteres)) => [
			items <=> "resultados"
			value <=> "poiSeleccionado"
		]	
		this.describeResultsGrid(table)}
		

	override protected addActions(Panel actionsPanel) {}
	
	
	}
	