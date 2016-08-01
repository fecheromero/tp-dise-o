package ui


import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Button
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.TextBox
import java.awt.Color
import ejercicio3.Conversor

class ConversorWindow extends MainWindow<Conversor> {

	new() {
		super(new Conversor)
	}

	def static main(String[] args) {
		new ConversorWindow().startApplication
	}

	override createContents(Panel mainPanel) {
		this.title = "Conversor texto al revés (XTend)"
		new Label(mainPanel).text = "Frase"
		new TextBox(mainPanel) => [
			value <=> "oracion"
			width = 200
		]

		new Label(mainPanel)=>[
			foreground<=>"color"
			value <=> "oracionInv"
			]
//		new Label(mainPanel).text = " oración al revés"
	}
	
}
