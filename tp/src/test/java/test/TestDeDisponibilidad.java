package test;

import static org.junit.Assert.*;

import org.joda.time.DateTime;
import org.joda.time.LocalTime;
import org.junit.Assert;
import org.junit.Test;


public class TestDeDisponibilidad {

	@Test
	public void test() {
		DateTime date = new DateTime();
		LocalTime hora =new LocalTime(15,0);
		//date = new DateTime("2016-04-11T13:30:00"); // milisegundos a 0
		date = new DateTime(2016, 4, 11, 15,0);
		int dayOfWeek = date.getDayOfWeek();
		//Assert.assertEquals(dayOfWeek,2);
		//Assert.assertEquals(date.getHourOfDay(),hora.getHourOfDay());
		Assert.assertEquals(date.toLocalTime(),hora);
		

	}
	
}
