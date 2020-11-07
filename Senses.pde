class Senses {
  ArrayList<PVector> m_repulsions = new ArrayList<PVector>();
  PVector m_attraction;
  float m_distanceToAttraction;

  ArrayList<Species> prey = new ArrayList<Species>();
  ArrayList<Species> predators = new ArrayList<Species>();

  private Organism m_self;
  private float distance = 50;

  public Senses(Organism organism) {
    m_self = organism;
  }

  void update() {
  }

  void clear() {
    m_repulsions.clear();
    m_attraction = null;
  }

  void update(Organism other) {
    PVector selfToOtherVector = other.displacement().copy().sub(m_self.displacement()); 
    float distanceBetweenCenters = selfToOtherVector.mag();

    if (distanceBetweenCenters > (other.mass + m_self.mass)/2 + distance)
    {
      return;
    }
    
    if (isAttraction(other) && (m_attraction == null || distanceBetweenCenters < m_distanceToAttraction) )
    {
      m_attraction = other.displacement();
      m_distanceToAttraction = distanceBetweenCenters;
    }
    else if (isRepulsion(other) )
    {
      m_repulsions.add(other.displacement());
    }
  }


  boolean isAttraction(Organism organism) {
    if (prey.contains(organism.species()))
    {
      return true;
    }

    return false;
  }

  boolean isRepulsion(Organism organism) {
    if (predators.contains(organism.species()))
    {
      return true;
    }

    return false;
  }
}

class SnakeSenses extends Senses {
  public SnakeSenses(Organism organism) {
    super(organism);
    prey.add(Species.Fish);
    predators.add(Species.Fish);
  }
}
class FishSenses extends Senses {
  public FishSenses(Organism organism) {
    super(organism);
    prey.add(Species.Algae);
    prey.add(Species.Snake);
    predators.add(Species.Snake);
  }
}
