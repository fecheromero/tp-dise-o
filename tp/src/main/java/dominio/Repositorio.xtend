package dominio

import excepciones.NoValidoException
import java.util.HashSet
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class Repositorio {
	ServicioExterno servicioExtCGP
	ServicioExternoBancos servicioExtBanco
	HashSet<PuntoDeInteres> puntos
	Buscador buscador=new Buscador()
	Transformer transformer = new Transformer()
	
	def void setServicioDTO(ServicioExterno servicio){
		servicioExtCGP=servicio
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
	
	def void createOrUpdate(PuntoDeInteres unPunto){
		
		try{
			this.create(unPunto)
		}catch (NoValidoException e){
			this.update(unPunto)		
		}
		
		
	}
	def PuntoDeInteres searchBynd(int id){
		puntos.get(id)
	}
	def List<PuntoDeInteres> search(String valor){
		buscador.mostrarPrimeros(valor,puntos,10)
	}

	def void actualizarRepositorio(String criterio){
		val List<CentroDTO> listaCentroDTO = servicioExtCGP.buscar(criterio)
		val listaCGPs = listaCentroDTO.map[dto | transformer.centroACGP(dto)]
		listaCGPs.forEach[cgp | this.createOrUpdate(cgp)]
		
		val HashSet<SucursalBanco> listaBancos = transformer.transformarDeJSONaClaseBanco(servicioExtBanco.buscar(criterio))
		listaBancos.forEach[banco | this.createOrUpdate(banco)]
	}



}