package views

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
import org.uqbar.arena.windows.Dialog

class BusquedaWindow extends SimpleWindow<BusquedaModel>{
	
	var TextBox textBoxCriterio2
	
	var Button agregarButton
	
	new(WindowOwner parent) {
		super(parent,new BusquedaModel)
		
	
	}
		override def createMainTemplate(Panel mainPanel) {
		title = "Buscador de Pois"
		taskDescription = "Ingrese los parámetros de búsqueda"

		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		new Button(mainPanel)=>[
					caption = "Mostrar"
		 			onClick[|
		 				if(modelObject.poiSeleccionado==null){showInfo("debe seleccionar un poi")}
		 				else{
		 				modelObject.poiSeleccionado.mostrar(this)
		 				}
		 			]
			disableOnError
		]
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
		 		textBoxCriterio2=new TextBox(panelIzquierdo)=>[
		 			value<=>"criterio2"
		 			visible<=>"visibleCriterio2"
		 		]
	
		 	val  panelDerecho=new Panel(panelPrincipal)=>[
		 		layout=new HorizontalLayout]
		 		agregarButton=new Button(panelDerecho)=>[
		 		bindCaptionToProperty("agregarButtonText")
		 		onClick([|agregarAccion])
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
		
	def void agregarAccion(){
		if(modelObject.visibleCriterio2){
			modelObject.agregarButtonText= "agregar"
			modelObject.criterio2=""
			modelObject.visibleCriterio2 = false
		}
		else{ 	modelObject.agregarButtonText="quitar"
		
			modelObject.visibleCriterio2 = true
		}
	}
	override protected addActions(Panel actionsPanel) {}
	
		def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}
	
	
	}
	