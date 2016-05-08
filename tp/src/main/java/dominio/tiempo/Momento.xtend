package dominio.tiempo

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class Momento {
	LocalDate fecha
	int hora
	int minuto
	int segundos

}
