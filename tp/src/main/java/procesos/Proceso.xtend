package procesos
import dominio.PerfilesDeUsuario.Administrador


interface Proceso {
	def void exec(Administrador adm)
	}