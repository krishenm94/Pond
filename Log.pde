public static class Log
{
  public static warning(String string)
  {
    log("WARNING: " + string);
  }
  
  public static error(String string)
  {
    log("ERROR: " + string);
  }
  
  public static debug(String string)
  {
    log("DEBUG:" + string)
  }
  
  public static info(String string)
  {
    log("INFO", string);
  }
  
  private log(String prefix, String message)
  {
    println(prefix + ": " + string);
  }
}
