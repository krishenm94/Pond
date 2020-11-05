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
  private final float GROWTH_RATE = 0.4;   
  ArrayList<PVector> m_points = new ArrayList<PVector>();

  FishAppearance(Organism organism, color colour)
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
    for (float i = m_points.size() - 1, taper = m_self.mass; i >= 0 && taper > 0; i--, taper -= m_self.mass / m_points.size())
    {
      PVector point = m_points.get(int(i));
      ellipse(point.x, point.y, m_self.mass - taper, m_self.mass - taper);
    }

    float r = m_self.mass / 2;
    PVector lastPoint = m_points.get(m_points.size() -1);
    PVector finHeadingVector = m_points.get(m_points.size() - 2).copy().sub(m_points.get(m_points.size()-1));
    finHeadingVector.normalize().mult(3);
    float heading = finHeadingVector.heading();

    translate(lastPoint.x + finHeadingVector.x, lastPoint.y  + finHeadingVector.y);
    rotate(heading);

    triangle( 0, 0, -r, -r, -r, r);

    rotate(-heading);
    translate(-(lastPoint.x + finHeadingVector.x), -(lastPoint.y  + finHeadingVector.y));
  }
}

class SnakeAppearance extends Appearance
{
  private final float GROWTH_RATE = 0.3;   
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
    for (float i = m_points.size() - 1, taper = m_self.mass; i >= 0 && taper > 0; i--, taper -= m_self.mass / m_points.size())
    {
      PVector point = m_points.get(int(i));
      ellipse(point.x, point.y, m_self.mass - taper, m_self.mass - taper);
    }
  }
}
