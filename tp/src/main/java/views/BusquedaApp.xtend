package views

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class BusquedaApp extends Application {
	new(BusquedaBootstrap bootstrap) {
		super(bootstrap)
	}
		static def void main(String[] args) {
		new BusquedaApp(new BusquedaBootstrap).start()
	}

	override protected Window<?> createMainWindow() {
		return new BusquedaWindow(this)
	}
}