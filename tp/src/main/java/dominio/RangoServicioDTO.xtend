package dominio
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RangoServicioDTO {
	int numeroDia
	int horarioDesde
	int minutosDesde
	int horarioHasta
	int minutosHasta
}