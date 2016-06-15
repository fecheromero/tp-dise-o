package procesos

import dominio.Repositorio
import dominio.PerfilesDeUsuario.Administrador

class BajaDePois extends Proceso {
	ServicioBajaPois serv
	Repositorio repo=Repositorio.instance
	new(ServicioBajaPois _serv){
		serv=_serv
	}
	override def void exec(Administrador adm){
		serv.poisEliminados.forEach[poiEliminado| if(repo.searchBynd(poiEliminado.id)!=null)
			{repo.delete(repo.searchBynd(poiEliminado.id))
		}
		]
	}
}