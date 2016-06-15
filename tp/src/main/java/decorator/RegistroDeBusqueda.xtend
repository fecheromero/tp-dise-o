package decorator

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class RegistroDeBusqueda {
  		String fecha
  		String fraseBuscada
  		int CantDeResultados
  		Terminal term
  		long demora
  		new (String _fecha, String _fraseBuscada, int CantDeResultados, Terminal _exec, long _demora){
  			fecha=_fecha
  			fraseBuscada=_fraseBuscada
  			cantDeResultados=CantDeResultados
  			term=_exec
  			 demora=_demora
  		}	
	}