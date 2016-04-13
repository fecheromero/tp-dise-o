package test

import dominio.Turno
import org.junit.Test
import org.junit.Before
import org.junit.Assert
import org.joda.time.LocalTime
import java.util.Set
import java.util.HashSet

class TestDisponibilidadPrueba {
	Turno turnoMañana
	Turno turnoTarde
	Turno turnoCompleto
	Turno turnoRentas
	Turno turnoRegistroCivil
	HashSet<Turno> turnosDisponiblesRentas
	HashSet<Integer> diasHabilesRentas
	
	@Before
	def void setUp() {
		turnoMañana = new Turno(new LocalTime(9, 0), new LocalTime(13, 0))
		turnoTarde = new Turno(new LocalTime(14, 0), new LocalTime(18, 0))
		diasHabilesRentas = new HashSet<Integer>
		diasHabilesRentas.addAll(1,2,3,4)
	}

	@Test
	def void testTurno() {
		Assert.assertEquals(turnoMañana.horaDentroDelTurno(new LocalTime (19,45)),false)
	}
}
