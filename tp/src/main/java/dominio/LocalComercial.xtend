package dominio

public abstract class LocalComercial extends PuntoDeInteres {

	override String listaDeTags() {
		super.listaDeTags().concat(this.tipo)
	}
}
