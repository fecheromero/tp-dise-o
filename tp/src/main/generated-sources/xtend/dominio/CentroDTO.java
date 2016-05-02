package dominio;

import dominio.ServicioDTO;
import java.util.ArrayList;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class CentroDTO {
  private Integer numeroComuna;
  
  private String zonasIncluidas;
  
  private String nombreDirector;
  
  private String domicilio;
  
  private String telefono;
  
  private ArrayList<ServicioDTO> serviciosDTO;
  
  @Pure
  public Integer getNumeroComuna() {
    return this.numeroComuna;
  }
  
  public void setNumeroComuna(final Integer numeroComuna) {
    this.numeroComuna = numeroComuna;
  }
  
  @Pure
  public String getZonasIncluidas() {
    return this.zonasIncluidas;
  }
  
  public void setZonasIncluidas(final String zonasIncluidas) {
    this.zonasIncluidas = zonasIncluidas;
  }
  
  @Pure
  public String getNombreDirector() {
    return this.nombreDirector;
  }
  
  public void setNombreDirector(final String nombreDirector) {
    this.nombreDirector = nombreDirector;
  }
  
  @Pure
  public String getDomicilio() {
    return this.domicilio;
  }
  
  public void setDomicilio(final String domicilio) {
    this.domicilio = domicilio;
  }
  
  @Pure
  public String getTelefono() {
    return this.telefono;
  }
  
  public void setTelefono(final String telefono) {
    this.telefono = telefono;
  }
  
  @Pure
  public ArrayList<ServicioDTO> getServiciosDTO() {
    return this.serviciosDTO;
  }
  
  public void setServiciosDTO(final ArrayList<ServicioDTO> serviciosDTO) {
    this.serviciosDTO = serviciosDTO;
  }
}
