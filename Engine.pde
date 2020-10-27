import java.util.*; 

Engine engine = new Engine();

class Engine
{
  private Vector<Mover> movers = new Vector<Mover>();

  public void add(Mover mover)
  {
    movers.add(mover);
  }

  public void update()
  {
    for (Mover mover : movers)
    {      
      mover.update();
    }
  }


  public void remove(Mover mover)
  {
    movers.removeElement(mover);
  }
}
