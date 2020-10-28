import java.util.*; 

class Engine
{
  private Vector<Motor> movers = new Vector<Motor>();

  public void add(Motor mover)
  {
    movers.add(mover);
  }

  public void update()
  {
    for (Motor mover : movers)
    {      
      mover.update();
    }
  }

  public void remove(Motor mover)
  {
    movers.removeElement(mover);
  }
  
  
}
