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
	private long id
	
	@Column
	int puntaje
	
	@Column(length=200)
	String comentario
	
	@Column(length=100)
	String usuario
	
	new() {
		
	}
	new(String _usuario,Integer _puntaje, String _comentario) {
		this.puntaje = _puntaje
		this.comentario = _comentario
		this.usuario=_usuario
	}
}
