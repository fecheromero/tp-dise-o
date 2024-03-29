package dependencias

import java.lang.annotation.Retention
import java.lang.annotation.Target
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.ElementType
import java.lang.annotation.Documented
import com.google.common.annotations.GwtCompatible
import java.lang.annotation.Target
import java.lang.annotation.Documented

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@Documented
@GwtCompatible
 public annotation Validable {

}