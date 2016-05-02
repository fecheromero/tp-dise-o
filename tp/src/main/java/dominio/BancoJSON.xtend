package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.math.BigDecimal
import java.util.ArrayList

@Accessors
public class BancoJSON {
	String banco
	BigDecimal x
	BigDecimal y
	String sucursal
	String gerente
	ArrayList<String> servicios
}