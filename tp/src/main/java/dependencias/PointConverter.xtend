package dependencias

import javax.persistence.Converter
import javax.persistence.AttributeConverter
import org.uqbar.geodds.Point

@Converter
public class PointConverter implements AttributeConverter<Point,String> {


		override convertToDatabaseColumn(Point attribute) {
		attribute.latitude.intValue.toString.concat("-").concat(attribute.longitude.intValue.toString)
		
		
		}
		
		override convertToEntityAttribute(String dbData) {
		new Point(Integer.parseInt(dbData.split("-").get(0)),Integer.parseInt(dbData.split("-").get(1)))
		}
		 


}