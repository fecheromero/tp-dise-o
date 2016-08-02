package saludo_de_personas

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox


class SaludoWindow extends MainWindow<Saludo>{
	new(){
		super(new Saludo)
	}
	
	override createContents(Panel mainPanel){
		this.title="Saludo"
		new Label(mainPanel).text="Ingrese Nombre"
		new TextBox(mainPanel) => [
   				 value <=> "nombre"
    			width = 200 ]
		new Label(mainPanel).text="Ingrese Apellido"
		new TextBox(mainPanel) => [
   				 value <=> "apellido"
    			width = 200 ]
    	new Label(mainPanel).value<=>"saludoCompleto"
	}

def static main(String[] args){
	new SaludoWindow().startApplication
}
		
}