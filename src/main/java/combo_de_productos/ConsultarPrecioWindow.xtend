package combo_de_productos
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import java.awt.Color
import org.uqbar.arena.bindings.PropertyAdapter

class ConsultarPrecioWindow extends MainWindow<ConsultarPrecio> {
	
	new(ConsultarPrecio con){
		super(con)
	
	}
	override createContents(Panel mainPanel){
		this.title="Productos"
		mainPanel.layout = new VerticalLayout
		new Label(mainPanel).text="Producto"
		new Selector<Producto>(mainPanel)=>[
			val itemsProperty=bindItemsToProperty("listaDeProductos")	
			allowNull=false
			items<=>"listaDeProductos"
			value<=>"producto"
			itemsProperty.adapter=new PropertyAdapter(typeof(Producto),"descripcion")
			]
		new Label(mainPanel).text="Precio"
		new Label(mainPanel)=>[
			value<=>"producto.precio"
			
			
			]
		
	}
	
	def static main(String[] args) {
		new ConsultarPrecioWindow(new ConsultarPrecio=>[
			listaDeProductos.addAll(#[new Producto(22.15,"mate"),new Producto(30.00,"galletitas"),new Producto(1.00,"caramelos")])
		]).startApplication
	}
	
}