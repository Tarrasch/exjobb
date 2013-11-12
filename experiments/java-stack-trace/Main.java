public class Main {
  public static void main(String[] args) {
    outScopeException();
    rethrowInHandler();
    rethrowOutsideHandler();
  }

  public static void outScopeException() {
    Exception e2 = new Exception();
    try {
      divByZero();
    }
    catch (Exception e) {
      e2 = e;
    }
    e2.printStackTrace(); // The exception value is used outside of it's handler
  }

  public static int divByZero() {
    return 1/0;
  }

  /*
   * You should always be able to rethrow in handler, and the whole stack
   * should be shown when the outer handler is printing the result
   */
  public static void rethrowInHandler() {
    try {
      inThrower();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static void inThrower() {
    try {
      divByZero();
    }
    catch (Exception e) {
      boolean anyExpression = e != null;
      if( anyExpression ) {
        // Oh noes, I can't handle this :(
        throw e;
      }
      else { 
        // Yay, I can handle, no need to rethrow :)
        System.out.println("yay");
      }
    }
  }

  public static void rethrowOutsideHandler() {
    try {
      outThrower();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  /*
   * For some reason, when you're throwing an exception different from exactly
   * the one you caught (e2 instead of e). It demands that you annotate with a
   * "throws Exception"
   */
  public static void outThrower() throws Exception {
    Exception e2 = null;
    try {
      divByZero();
    }
    catch (Exception e) {
      e2 = e;
    }
    throw e2;
  }
}
