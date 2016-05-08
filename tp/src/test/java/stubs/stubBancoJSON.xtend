package stubs

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class stubBancoJSON {
	String banco
	double x
	double y
	String sucursal
	String gerente
	ArrayList<String> servicios

new (String banco, double x, double y, String sucursal, String gerente, ArrayList<String> servicios){
	this.banco = banco 
	this.x = x
	this.y = y
	this.sucursal = sucursal
	this.gerente = gerente
	this.servicios = servicios
	
}
}
