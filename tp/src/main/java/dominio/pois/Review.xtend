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
	int Id
	@Column
	int puntaje
	@Column
	String comentario
	@Column
	String usuario
	
	new() {
		
	}
	new(String _usuario,Integer _puntaje, String _comentario) {
		puntaje = _puntaje
		comentario = _comentario
		usuario=_usuario
	}
}
