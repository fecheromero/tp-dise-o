package test

import dominio.Busqueda
import org.junit.Before
import dominio.Repositorio
import fixtures.LibreriaFixture
import fixtures.ParadaColectivoFixture

class TestBusqueda {
	Busqueda busqueda
	Repositorio repo
	@Before
	def void SetUp(){
		
		repo.create(new LibreriaFixture().obtenerLibreria)
		repo.create(new ParadaColectivoFixture().obtenerParadaColectivo)
		busqueda.agregarOrigen(repo)
		//Falta crear una interfaz de cada una con algun que otro punto para probar esto.
		//despues de crearlas hay que asignarlas a adapters y meter los adapters como Origenes en la busqueda.
		//Con eso se puede testear ya la busqueda generalizada.
	}
	}