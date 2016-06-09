package procesos

import dominio.Repositorio

class BajaDePois implements Proceso {
	ServicioBajaPois serv
	Repositorio repo=Repositorio.instance
	new(ServicioBajaPois _serv){
		serv=_serv
	}
	override def void exec(){
		serv.poisEliminados.forEach[poiEliminado| if(repo.searchBynd(poiEliminado.id)!=null)
			{repo.delete(repo.searchBynd(poiEliminado.id))
		}
		]
	}
}