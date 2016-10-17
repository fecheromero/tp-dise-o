package dominio.tiempo;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

public enum Dia {
		LUN(1),
	    MAR(2),
	    MIE(3),
	    JUE(4),
	    VIE(5),
	    SAB(6),
	    DOM(7);
	    

	    private final int num;
	    Dia(int _num) {
	        this.num =_num;
	        }
	    public int num() { return num;
	    }
	    }


