public class InOut {
  public static void main(String[] args) {
    insideSame();
    insideNew();
    outsideSame();
    outsideNew();
  }

  public static abstract class CatchPrint {
    public abstract void body() throws Exception;
    public void run() {
      try {
        body();
      } catch(Exception e) {
        e.printStackTrace();
      }
    }
    CatchPrint() {
      run();
    }
  }

  public static void insideSame() {
    new CatchPrint() {
      public void body() {
        try {
          divByZero();
        } catch (Exception e) {
          throw e;
        }
      }
    };
  }

  public static void insideNew() {
    new CatchPrint() {
      public void body() throws Exception {
        try {
          divByZero();
        } catch (Exception e) {
          throw new Exception("Oh noes, I couldn't handle");
        }
      }
    };
  }

  public static void outsideSame() {
    new CatchPrint() {
      public void body() throws Exception {
        Exception e2 = new Exception("unreachable code");
        try {
          divByZero();
        } catch (Exception e) {
          e2 = e;
        }
        throw e2;
      }
    };
  }

  public static void outsideNew() {
    new CatchPrint() {
      public void body() throws Exception {
        Exception e2 = new Exception("unreachable code");
        try {
          divByZero();
        } catch (Exception e) {
          e2 = e;
        }
        throw new Exception("This definetly is a new fresh throw!");
      }
    };
  }

  public static int divByZero() {
    return 1/0;
  }

}
