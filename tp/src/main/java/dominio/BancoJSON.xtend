package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.math.BigDecimal
import java.util.ArrayList

@Accessors
public class BancoJSON {
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