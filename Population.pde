import java.util.*; 

boolean BIOMASS_LOCK = false;

int SNAKE_COUNT_INIT = 3;
int FISH_COUNT_INIT = 12;

static int POPULATION_SIZE = 100;
float BIOMASS_LIMIT = 3000;

int fishCount = 0;
int snakeCount = 0;

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

    if (genome == null)
    {
      Log.error("Null genome, skipping random organism creation");
      return null;
    }

    if (genome.species == Species.Fish)
    {
      fishCount++;
      if (fishCount > FISH_COUNT_INIT) 
      {
        return null;
      }
    }

    if (genome.species == Species.Snake)
    {
      snakeCount++;
      if (snakeCount > SNAKE_COUNT_INIT) 
      {
        return null;
      }
    }

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
    feedingAndOverlapDetection();
    babyTime();

    HashMap<Species, Integer> speciesCount = new HashMap<Species, Integer>();
    float mass = 0;

    for (Organism organism : organisms)
    {  
      organism.update();
      organism.show();

      if (!BIOMASS_LOCK)
      {
        organism.photosynthesise();
      }

      mass += organism.mass;

      if (speciesCount.containsKey(organism.species())) { 
        speciesCount.put(organism.species(), speciesCount.get(organism.species()) + 1);
      } else {  
        speciesCount.put(organism.species(), 1);
      }
    }

    BIOMASS_LOCK = mass > BIOMASS_LIMIT ? true : false;

    Log.info("Total biomass: " + mass);
    Log.info("Population size : " + organisms.size());

    for (Map.Entry<Species, Integer> entry : speciesCount.entrySet())
      Log.info("Species: " + entry.getKey()+ ", Count: " + entry.getValue());
  }

  private void babyTime()
  {
    Vector<Organism> theBabies = new Vector<Organism>();
    for (Organism organism : organisms)
    {  
      if (organism.howFat() <= 0)
      {
        continue;
      }

      float babyChance = random(0, 1);

      if (babyChance < organism.howFat())
      {
        theBabies.add(organism.makeBaby());
      }
    }

    organisms.addAll(theBabies);
  }

  private void feedingAndOverlapDetection()
  {
    Vector<Organism> theDead = new Vector<Organism>();
    for (Organism organism : organisms)
    {      
      if (organism.isDead)
      {
        theDead.add(organism);
        continue;
      }

      fightTheOthers(organism);

      if (organism.isDead) {
        theDead.add(organism);
      }
    }

    organisms.removeAll(theDead);
  }

  private void fightTheOthers(Organism organism)
  {
    for (Organism other : organisms)
    {
      if (other == organism || !areMeeting(organism, other) || other.isDead) {
        continue;
      }

      if (other.species() == organism.species()) 
      {
        organism.collidingWith = other;
        other.collidingWith = organism;

        continue;
      }

      if (organism.canIEat(other)) {
        organism.chomp(other);
        continue;
      } else if (other.canIEat(organism)) {
        other.chomp(organism);
        continue;
      } else
      {
        organism.collidingWith = other;
        other.collidingWith = organism;
      }
    }
  }

  public void remove(Organism organism)
  {
    organisms.removeElement(organism);
  }

  boolean areMeeting(Organism organism1, Organism organism2)
  {
    Overlap overlap = new Overlap(organism1, organism2);

    boolean isOverlapping = overlap.type == _Overlap.Type.None? false : true;

    if (isOverlapping)
    {
      painter.show(organism1, WHITE, DRAW_OVERLAP || DRAW_COLLISION);
      painter.show(organism2, WHITE, DRAW_OVERLAP || DRAW_COLLISION);
    }

    return isOverlapping;
  }
}
