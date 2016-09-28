package views

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
 
class LoginWindow extends Dialog<Usuario>{
	new(){
 		super(new Usuario)
 	}
 /*	 override createContents(Panel mainPanel){
	 	this.title="Login"
	 	new Label(mainPanel).text="Usuario"
	 	new TextBox(mainPanel) => [
    		 	value <=> "nombreUsuario"
    			width = 200 ]
    	new Label(mainPanel).text="Contraseña"
    	new TextBox(mainPanel) => [
    			value <=> "contraseña"
     			width = 200 ]
     	new Button(mainPanel) => [
			caption = "Ingresar"
			onClick [ | this.modelObject. ]
		]
	 }*/
	 	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		
		new Label(form).text = "Usuario"
		new TextBox(form) =>[
			width = 200
			value <=> "nombreUsuario"	
		] 

		new Label(form).text = "Contrañeña"
		new TextBox(form) => [
			width = 200
			value <=> "contraseña"
		]

		this.addFormPanel(form)
	}

	abstract def void addFormPanel(Panel panel)

	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [ | this.accept ]
			.setAsDefault
			.disableOnError

		new Button(actions) //
			.setCaption("Cancelar")
			.onClick[|this.cancel]
	}
	  
}