package observer

import dominio.PerfilesDeUsuario.PerfilDeUsuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class AlmacenamientoDeBusqueda extends Accion {

override buscar(String frase, Long tiempo, int cantidad, PerfilDeUsuario user) {
		if (user.estaHabilitadaLaAccion(this)) {
		var fechaDeEjecucion = new LocalDate(LocalDate.now.getYear(), LocalDate.now.getMonthOfYear(),
			LocalDate.now.getDayOfMonth())
		var resultado = new RegistroPorBusqueda(frase, cantidad, tiempo, fechaDeEjecucion, user)
		RepositorioDeConsultas.getInstance.listaDeBusquedas.add(resultado)}
				
		}
		}