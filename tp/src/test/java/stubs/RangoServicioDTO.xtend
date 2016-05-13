package stubs
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RangoServicioDTO {
	int numeroDia
	int horarioDesde
	int minutosDesde
	int horarioHasta
	int minutosHasta
	
	new (int dia,int horaDesde, int minutosD,int horaHasta, int minutosH ){
		numeroDia=dia
		horarioDesde=horaDesde
		horarioHasta=horaHasta
		minutosDesde=minutosD
		minutosHasta=minutosH
		
	}
}
