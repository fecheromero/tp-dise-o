import java.awt.Color
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.MainWindow

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CalculadoraWindow extends MainWindow<Calculadora> {
	new() {
		super(new Calculadora)
	}

	override createContents(Panel mainPanel) {
		this.title = "Sumando Operandos"

		// new ErrorsPanel(mainPanel, "Listo para Sumar")
		new Label(mainPanel).text = "Operando 1"

		new NumericField(mainPanel) => [
			value <=> "operando1"
			width = 100
		]

		new Label(mainPanel).text = "Operando 2"

		new NumericField(mainPanel) => [
			value <=> "operando2"
			
		]

		new Button(mainPanel) => [
			setFontSize(12)
			setBackground(Color.yellow)
			setAsDefault
			disableOnError
			caption = "+"
			onClick [|this.modelObject.calcular]
		]

		new Label(mainPanel) => [
			value <=> "resultado"
			background = Color.lightGray
			setForeground(Color.blue)
			setFontSize(14)
		]

	}

	def static main(String[] args) {
		new CalculadoraWindow().startApplication
	}
}
