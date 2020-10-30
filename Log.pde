public static class Log
{
  public static void warning(String string)
  {
    log("WARNING", string);
  }
  
  public static void error(String string)
  {
    log("ERROR", string);
  }
  
  public static void debug(String string)
  {
    log("DEBUG", string);
  }
  
  public static void info(String string)
  {
    log("INFO", string);
  }
  
  private static void log(String prefix, String message)
  {
    println(prefix + ": " + message);
  }
}
