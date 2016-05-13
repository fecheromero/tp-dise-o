package dependencias;

import java.awt.List;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Stream;

import excepciones.NoValidoException;


public interface Validator {
	default ArrayList<Class> hierarchy(){
		 ArrayList<Class> clases=new ArrayList<Class>();
		 Class klass=this.getClass();
		while(klass!=new Object().getClass())
		{ clases.add(klass);
			klass=klass.getSuperclass();
	}
	return clases;}
	
	 default Stream<Field> fieldsOfHierarchy(){
		return this.hierarchy().stream().flatMap(klass->Arrays.asList(klass.getDeclaredFields()).stream());
	}
	 default Stream<Field>fieldsAnnotationFilter(Class anotation,Stream<Field> fields) {
		 return fields.filter(unField->unField.isAnnotationPresent(anotation));
	 }
	 default void sendValidate(Object obj){
		 try { if(obj!=null){
			Validator.class.getMethod("validate", null).invoke( obj, null);}
		 else{throw new NoValidoException("A collection contain null");}
		} catch (IllegalArgumentException | IllegalAccessException | InvocationTargetException
				| NoSuchMethodException | SecurityException e) {
			if(e.getCause().getClass()==NoValidoException.class) {throw new NoValidoException("el objeto no es valido");}
			else{throw new RuntimeException("unknown error");}
		}
	 }
	 default void fieldControl(Field unField)  { 		 	
	 unField.setAccessible(true);
					try{
					if(unField.get(this)==null){
						throw new NoValidoException("el objeto no es valido");
					}
						if(unField.get(this) instanceof Validator){
							sendValidate(unField.get(this));
						}
						if(unField.get(this) instanceof Collection<?> && ((Collection<?>) unField.get(this)).stream().anyMatch(elem->elem instanceof Validator)){
								((Collection<?>)unField.get(this)).forEach(elem1->sendValidate(elem1));
						}
					} catch (IllegalArgumentException | IllegalAccessException| SecurityException e) {
						if(e.getCause().getClass()==NoValidoException.class) {throw new NoValidoException("el objeto no es valido");}
						else{throw new RuntimeException("unknown error");}
					}
					
				
			
	 }
	 default void validate() {
 this.fieldsAnnotationFilter(Validable.class, this.fieldsOfHierarchy()).forEach(unField-> this.fieldControl(unField));
	 
	/*default void validate() {
		try{this.hierarchy().stream().flatMap(klass-> 
			Arrays.asList(klass.getDeclaredFields()).stream().filter(field-> field.isAnnotationPresent(Validable)
		).forEach(fieldAnotation-> { fieldAnotation.setAccessible(true);
			if(fieldAnotation.get(this)==null) {
				throw new NoValidoException("El objeto no es valido");
			};
			if(Validator.class.isAssignableFrom(fieldAnotation)){
				Validable.class.getMethod("validate",null).invoke(fieldAnotation.get(this),null);
			}
		}
		))
		}catch(InvocationTargetException e) {throw e.cause;}
}*/
	 }
}