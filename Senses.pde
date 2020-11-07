float ATTRACTION_RATE = 2;
float REPULSION_RATE = 3;

class Senses {
  PVector m_attraction;
  float m_distanceToRepulsion;
  PVector m_repulsion;
  float m_distanceToAttraction;

  ArrayList<Species> prey = new ArrayList<Species>();
  ArrayList<Species> predators = new ArrayList<Species>();

  private Organism m_self;
  private float distance = 100;

  public Senses(Organism organism) {
    m_self = organism;
  }

  void update(Organism other) {
    PVector selfToOtherVector = other.displacement().copy().sub(m_self.displacement()); 
    float distanceBetweenCenters = selfToOtherVector.mag();
    float distanceBetween = distanceBetweenCenters - (other.mass + m_self.mass)/2;

    if (distanceBetween > distance)
    {
      return;
    } 

    if (isAttraction(other) && 
      (m_attraction == null|| m_distanceToAttraction > distanceBetween) )
    {
      m_attraction = other.displacement().copy();
      m_distanceToAttraction = distanceBetween;
    } else if (isRepulsion(other) && 
      (m_repulsion == null || m_distanceToRepulsion > distanceBetween) )
    {
      m_repulsion = other.displacement().copy();
      m_distanceToRepulsion = distanceBetween;
    }
  }

  void execute() {
    if (m_attraction != null)
    {
      attract();
    }

    if ( m_repulsion != null)
    {
      repulse();
    }
  }

  void attract() {
    Log.debug("Attracting");
    PVector selfToAttractionVector = m_attraction.copy().sub(m_self.displacement());
    selfToAttractionVector.normalize().mult(ATTRACTION_RATE);
    m_self.displacement().add(selfToAttractionVector);
    m_attraction = null;
  }    

  void repulse() {
    Log.debug("Repulsing");
    PVector selfToRepulsionVector = m_repulsion.sub(m_self.displacement());
    selfToRepulsionVector.normalize().mult(REPULSION_RATE);
    m_self.displacement().sub(selfToRepulsionVector);
    m_repulsion = null;
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
  }
}

class FishSenses extends Senses {
  public FishSenses(Organism organism) {
    super(organism);
    prey.add(Species.Algae);
    predators.add(Species.Snake);
  }
}

class AlgaeSenses extends Senses {
  public AlgaeSenses(Organism organism) {
    super(organism);
  }
}
