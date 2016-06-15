package decorator

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class RegistroDeBusqueda {
  		String fecha
  		String fraseBuscada
  		int CantDeResultados
  		BusquedaExecuter exec
  		long demora
  		new (String _fecha, String _fraseBuscada, int CantDeResultados, BusquedaExecuter _exec, long _demora){
  			fecha=_fecha
  			fraseBuscada=_fraseBuscada
  			cantDeResultados=CantDeResultados
  			exec=_exec
  			 demora=_demora
  		}	
	}