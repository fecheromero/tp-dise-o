package dependencias

import java.util.List
import java.util.ArrayList
import dependencias.Validable
import excepciones.NoValidoException
import java.lang.reflect.InvocationTargetException

class ValidableObject {
	def ArrayList<Class> hierarchy(){
		var ArrayList<Class> clases=new ArrayList<Class>
		var Class klass=this.class
		while(klass!=ValidableObject)
		{ clases.add(klass)
			klass=klass.superclass
	}
	clases
	}
	def void validate() {
			try{this.hierarchy().map[klass| 
				klass.declaredFields.filter[field| field.isAnnotationPresent(Validable)]
			].flatten.forEach[fieldAnotation| fieldAnotation.accessible=true
				if(fieldAnotation.get(this)==null) {
					throw new NoValidoException("El objeto no es valido")
				}
				if(ValidableObject.isAssignableFrom(fieldAnotation.get(this).class)){
					ValidableObject.getMethod("validate",null).invoke(fieldAnotation.get(this),null)
					
				}
			]} catch(InvocationTargetException e) {throw e.cause}
		/*if(this.hierarchy().exists[class| 
				class.declaredFields.filter[field| 
				field.isAnnotationPresent(Validable)
		]
			.exists[fieldAnotation| fieldAnotation.accessible=true
										
									 if(ValidableObject.isAssignableFrom(fieldAnotation.get(this).class)){
									   ValidableObject.getMethod("validate",null).invoke(fieldAnotation.get(this),null)
									   return false
									   }
									 fieldAnotation.get(this)==null
									 
			]
	
		]) throw new NoValidoException("El objeto no es valido")		
	*/
	}
	}