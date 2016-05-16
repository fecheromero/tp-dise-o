package observer

import dominio.PerfilesDeUsuario.Administrador

interface MailSender {
	def void send(Administrador admin)
}