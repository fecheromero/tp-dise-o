package dominio.pois

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column

@Accessors
@Entity
class Review {
	@Id
	@GeneratedValue
	private int Id
	@Column
	int puntaje
	@Column(length=200)
	String comentario
	@Column(length=100)
	String usuario
	
	new() {
		
	}
	new(String _usuario,Integer _puntaje, String _comentario) {
		puntaje = _puntaje
		comentario = _comentario
		usuario=_usuario
	}
}
