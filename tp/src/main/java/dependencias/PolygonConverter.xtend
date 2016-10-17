package dependencias

import javax.persistence.AttributeConverter
import javax.persistence.Converter
import org.uqbar.geodds.Polygon

@Converter
class PolygonConverter  implements AttributeConverter<Polygon,String> {
	
	override convertToDatabaseColumn(Polygon attribute) {
	
		}
	
	override convertToEntityAttribute(String dbData) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}