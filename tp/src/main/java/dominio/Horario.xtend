package dominio

import java.util.List

public abstract class Horario {
	List<String> diasHabilesPoi

	def boolean estaAbierto()

	def void setearDiasHabiles(List<String> diasHabiles) {
		this.diasHabilesPoi = diasHabiles
	}

	def boolean esHabilElMomento(Momento unMomento)

}
