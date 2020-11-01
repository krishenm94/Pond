import java.util.*; 

boolean BIOMASS_LOCK = false;

static int POPULATION_SIZE = 100;
float BIOMASS_LIMIT = 3000;

class Population
{
  float mass;

  private Vector<Organism> organisms = new Vector<Organism>();

  void init(int size)
  {  
    for (int i = 0; i <size; i++) {
      add();
    }
  }

  Organism add(Organism organism)
  {
    organisms.add(organism);
    return organism;
  }

  Organism add()
  {
    Genome genome = pangenome.randomGenome();

    Log.debug(genome.species + " " + genome.initCountMax);
    if (genome.initCount > genome.initCountMax) {
      return null;
    }

    genome.initCount++;

    return add(new Organism(randomDisplacement(), genome));
  }

  PVector randomDisplacement()
  {
    PVector displacement = new PVector();
    displacement.x = random(0, width);
    displacement.y = random(0, height);
    return displacement;
  }

  public void update()
  {
    HashMap<Species, Integer> speciesCount = new HashMap<Species, Integer>();

    for (Species species : pangenome.SPECIES_LIST)
    {
      speciesCount.put(species, 0);
    }
    float mass = 0;

    Vector<Organism> theBabies = new Vector<Organism>();
    Vector<Organism> theDead = new Vector<Organism>();

    for (Organism organism : organisms)
    { 
      organism.update();
      if (organism.isDead)
      {
        theDead.add(organism);
        continue;
      }

      organism.show();

      interactWithOthers(organism);

      float babyChance = random(0, 1);
      if (babyChance < organism.howFat() && organism.howFat() > 0)
      {
        theBabies.add(organism.makeBaby());
      }

      if (!BIOMASS_LOCK)
      {
        organism.photosynthesise();
      }

      mass += organism.mass;

      speciesCount.put(organism.species(), speciesCount.get(organism.species()) + 1);
    }

    organisms.removeAll(theDead);
    organisms.addAll(theBabies);
    BIOMASS_LOCK = mass > BIOMASS_LIMIT ? true : false;

    Log.info("Total biomass: " + mass);
    Log.info("Population size : " + organisms.size());

    for (Map.Entry<Species, Integer> entry : speciesCount.entrySet())
    {
      Log.info("Species: " + entry.getKey()+ ", Count: " + entry.getValue());
    }
  }

  private void interactWithOthers(Organism organism)
  {
    if (organism.isDead)
    {
      return;
    }

    for (Organism other : organisms)
    {
      if (other == organism || !areMeeting(organism, other) || other.isDead) {
        continue;
      }

      if (other.species() == organism.species()) 
      {
        organism.collidingWith.add(other);
        other.collidingWith.add(organism);

        continue;
      }

      if (organism.canIEat(other)) {
        organism.chomp(other);
      } else if (other.canIEat(organism)) {
        other.chomp(organism);
      } else {
        organism.collidingWith.add(other);
        other.collidingWith.add(organism);
      }
    }
  }

  public void remove(Organism organism)
  {
    organisms.removeElement(organism);
  }

  boolean areMeeting(Organism organism1, Organism organism2)
  {
    PVector selfToOtherVector = organism2.displacement().copy().sub(organism1.displacement()); 
    float distanceBetweenCenters = selfToOtherVector.mag();
    if (distanceBetweenCenters > (organism2.mass + organism1.mass)/2)
    {
      return false;
    } else
    {
      painter.show(organism1, WHITE, DRAW_OVERLAP || DRAW_COLLISION);
      painter.show(organism2, WHITE, DRAW_OVERLAP || DRAW_COLLISION);
      return true;
    }
  }
}
