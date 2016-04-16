package dominio


import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public abstract class LocalComercial extends PuntoDeInteres {

	
		var String rubro
		override String listaDeTags(){
			super.listaDeTags().concat(" ".concat(rubro))
		}
}
