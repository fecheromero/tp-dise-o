package procesos
import dominio.PerfilesDeUsuario.Administrador
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Proceso {
	RepositorioProcesos repositorio
	def void exec(Administrador adm)
	}