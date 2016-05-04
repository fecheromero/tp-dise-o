package dominio

import excepciones.NoValidoException
import java.util.HashSet
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Repositorio {
	ServicioExterno servicioExt
	HashSet<PuntoDeInteres> puntos
	Buscador buscador=new Buscador()
	
	def void setServicioDTO(ServicioExterno servicio){
		servicioExt=servicio
	}
	def void create(PuntoDeInteres unPunto){
		unPunto.validate()
		if(puntos.contains(unPunto)) throw new NoValidoException("El Punto ya existe")
		else{puntos.add(unPunto)}
	}
	def void update(PuntoDeInteres unPunto){
		delete(unPunto)
		create(unPunto)
	}
	def void delete(PuntoDeInteres unPunto){
		if(puntos.contains(unPunto))puntos.remove(unPunto)
		else{throw new NoValidoException("El Punto no existe")}
	}
	def PuntoDeInteres searchBynd(int id){
		puntos.get(id)
	}
	def List<PuntoDeInteres> search(String valor){
		buscador.mostrarPrimeros(valor,puntos,10)
	}}