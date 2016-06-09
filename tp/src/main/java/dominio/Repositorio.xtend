package dominio

import dependencias.Buscador
import dominio.pois.PuntoDeInteres
import excepciones.NoValidoException
import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import interfazAServiciosExternos.InterfazCGP
import java.util.ArrayList

@Accessors
class Repositorio implements OrigenDePois {
	InterfazCGP servicioExtCGP
	List<PuntoDeInteres> puntos=new ArrayList<PuntoDeInteres>
	Buscador buscador=Buscador.getInstance
	private static Repositorio uno=new Repositorio()
		private new( ){}
		def public static Repositorio getInstance(){
			uno
		}
	def void reset(){
		uno=new Repositorio()
	}
	

	def void setServicioDTO(InterfazCGP servicio){
		servicioExtCGP=servicio
	}
	def void create(PuntoDeInteres unPunto){
		unPunto.validate()
		if(searchBynd(unPunto.id)!=null) throw new NoValidoException("El Punto ya existe")
		else{puntos.add(unPunto)
		}
	}
	def void update(PuntoDeInteres unPunto){
		unPunto.validate
		delete(unPunto)
		create(unPunto)
	}
	def void delete(PuntoDeInteres unPunto){
		if(searchBynd(unPunto.id)!=null)puntos.remove(searchBynd(unPunto.id))
		else{throw new NoValidoException("El Punto no existe")}
	}
	
		
	def PuntoDeInteres searchBynd(int id){
		puntos.findFirst[punto| punto.id==id]
	}
	def override List<PuntoDeInteres> buscar(String valor){
		buscador.mostrarPrimeros(valor,puntos,10)
	}
/*
	def void actualizarRepositorio(String criterio){
		val List<CentroDTO> listaCentroDTO = servicioExtCGP.buscar(criterio)
		val listaCGPs = listaCentroDTO.map[dto | transformer.centroACGP(dto)]
		listaCGPs.forEach[cgp | this.createOrUpdate(cgp)]
		
		val HashSet<SucursalBanco> listaBancos = transformer.transformarDeJSONaClaseBanco(servicioExtBanco.buscar(criterio))
		listaBancos.forEach[banco | this.createOrUpdate(banco)]
	}
 */


}