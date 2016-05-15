package decorator

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RegistroDeBusqueda {
  		String fecha
  		String fraseBuscada
  		int CantDeResultados
  		Terminal terminal
  		long demora
  		new (String _fecha, String _fraseBuscada, int CantDeResultados, Terminal _terminal, long _demora){
  			fecha=_fecha
  			fraseBuscada=_fraseBuscada
  			cantDeResultados=CantDeResultados
  			terminal=_terminal
  			 demora=_demora
  		}	
	}