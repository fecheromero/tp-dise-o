package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Review {
	int puntaje
	String comentario
	String usuario
	new(String _usuario,Integer _puntaje, String _comentario) {
		puntaje = _puntaje
		comentario = _comentario
		usuario=_usuario
	}
}
