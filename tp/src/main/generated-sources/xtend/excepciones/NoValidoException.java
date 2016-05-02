package excepciones;

@SuppressWarnings("all")
public class NoValidoException extends Exception {
  public NoValidoException(final String msg) {
    super(msg);
  }
}
