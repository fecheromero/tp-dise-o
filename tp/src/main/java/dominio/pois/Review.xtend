package dominio.pois

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
