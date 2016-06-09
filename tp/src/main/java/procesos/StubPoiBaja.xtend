package procesos

import org.joda.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date
import java.text.SimpleDateFormat

@Accessors
class StubPoiBaja {
	int id
	String fecha
	
	new(int _id, String _fecha){
		id=_id
		fecha=_fecha
	}
	}