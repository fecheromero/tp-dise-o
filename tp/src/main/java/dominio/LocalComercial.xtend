package dominio

abstract class LocalComercial extends PuntoDeInteres{
	String tipo
	override String listaDeTags(){
		super.listaDeTags().concat(this.tipo)
	}
}