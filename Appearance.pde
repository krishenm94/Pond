import java.util.*; //<>//

class Appearance {
  protected color m_colour;
  protected Organism m_self;

  Appearance(Organism organism, color colour)
  {
    m_self = organism;
    m_colour = colour;
  }

  public void show()
  {
    fill(m_colour);
    ellipse(m_self.displacement().x, m_self.displacement().y, m_self.mass, m_self.mass);
  }
}

class AlgaeAppearance extends Appearance
{
  AlgaeAppearance(Organism organism, color colour)
  {
    super(organism, colour);
  }
}

class FishAppearance extends Appearance
{
  FishAppearance(Organism organism, color colour)
  {
    super(organism, colour);
  }

  public void show()
  {
    fill(m_colour);
    float x = m_self.displacement().x;
    float y = m_self.displacement().y;
    float r = m_self.mass / 2;

    ellipse(m_self.displacement().x, m_self.displacement().y, m_self.mass, m_self.mass);

    float heading = m_self.velocity().heading();

    translate(x, y);
    rotate(heading);
    
    // drawn with 60 deg 
    triangle(-1.5 * r, 0, 
      -r/2 , -r/2, 
      -r/2 , r/2); 

    triangle( -1.5 * r, 0, 
      -2.5 * r, -r, 
      -2.5 * r, r);

    rotate(-heading);
    translate(-x, -y);
  }
}

class SnakeAppearance extends Appearance
{
  private final float GROWTH_RATE = 0.5;   
  ArrayList<PVector> m_points = new ArrayList<PVector>();

  SnakeAppearance(Organism organism, color colour)
  {
    super(organism, colour);

    for (float i = 0; i <= organism.mass; i += GROWTH_RATE)
    {
      m_points.add(organism.displacement().copy());
    }
  }

  public void show()
  {
    int newPointCount = int(m_self.mass / GROWTH_RATE) + 1;
    int currentPointCount = m_points.size();

    if (currentPointCount >= newPointCount) { 
      m_points.remove(m_points.size()-1);
    }

    if (currentPointCount > newPointCount) {
      m_points.remove(m_points.size()-1);
    } 

    m_points.add(0, m_self.displacement().copy());

    fill(m_colour); 
    for (float i = m_points.size() - 1, taper = m_self.mass; i >= 0 && taper > 0; i--, taper -= GROWTH_RATE)
    {
      PVector point = m_points.get(int(i));
      ellipse(point.x, point.y, m_self.mass - taper, m_self.mass - taper);
    }
  }
}
