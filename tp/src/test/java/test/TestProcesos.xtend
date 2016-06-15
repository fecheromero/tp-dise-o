package test

import org.junit.Test
import org.junit.Assert
import org.junit.Before
import procesos.ActualizarLocalesComerciales
import fixtures.KioscoFixture
import dominio.Repositorio
import dominio.pois.PuntoDeInteres
import dominio.locales.LocalComercial
import procesos.BajaDePois
import procesos.ServicioBajaPois
import org.mockito.Mockito
import procesos.StubPoiBaja
import org.joda.time.DateTime
import org.joda.time.LocalDate
import java.util.HashSet
import java.util.ArrayList
import dominio.PerfilesDeUsuario.Administrador
import dominio.Busqueda

class TestProcesos {
	ActualizarLocalesComerciales actualizador1
	ActualizarLocalesComerciales actualizador2
	KioscoFixture fixtKiosco
	Repositorio repo
	BajaDePois baja1
	ServicioBajaPois serv
	Administrador adm
	Busqueda busqueda
	@Before
	def void setUp(){
		fixtKiosco= new KioscoFixture()
		actualizador1=new ActualizarLocalesComerciales("lo de tucu;Kiosko caramelos alfajores") 
		actualizador2=new ActualizarLocalesComerciales("saraza;Kiosko caramelos alfajores") 
		serv = Mockito.spy(new ServicioBajaPois())
		var HashSet<StubPoiBaja> bajas= new HashSet<StubPoiBaja> 
		bajas.add(new StubPoiBaja(1,"12-12-2012"))
		bajas.add(new StubPoiBaja(4,"12-12-2012"))
		baja1=new BajaDePois(serv)
		Mockito.when(serv.poisEliminados).thenReturn(bajas)
		repo=Repositorio.instance
		repo.create(fixtKiosco.obtenerKiosco)
		busqueda=new Busqueda
		adm=new Administrador(busqueda)
	}
	//Actualizar locales comerciales
@Test
def void testSplit(){
	Assert.assertEquals("saraza;colegio familia otro".split(";").get(0),"saraza")
}
@Test
def void testActualizarLocalesComerciales(){
	actualizador1.exec(adm)
	var LocalComercial local=repo.buscar("tucu").get(0) as LocalComercial
	Assert.assertEquals(local.listaDeTags.contains("alfajores"),true)
	actualizador1.exec(adm)
	Assert.assertEquals(local.otrosTags,"  Kiosko alfajores caramelos")
	
}

@Test
def void testActualizarUnLocalQueNoExisteNoRompeNiHaceNada(){
	actualizador2.exec(adm)
}
//Baja de pois
@Test
def void testBajaPois(){
	
		repo.reset
		repo=Repositorio.instance
	repo.create(fixtKiosco.obtenerKiosco)
	baja1.exec(adm)
	Assert.assertEquals(repo.puntos.size,1)
	
}
}