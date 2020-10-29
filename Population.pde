import java.util.*; 

float HOW_FAT_TO_MAKE_BABY_MULTIPLIER = 0.05;

class Population
{
  private Vector<Organism> organisms = new Vector<Organism>();

  void init(int size)
  {
    for (int i = 0; i <size; i++)
    {
      add();
    }
  }

  public void add(Organism organism)
  {
    organisms.add(organism);
  }

  public void add()
  {
    add(new Organism(randomDisplacement(), PanGenome.random()));
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
    feedingTime();
    babyTime();

    int wormCount = 0;
    int snakeCount = 0;
    float populationBiomass = 0;
    
    for (Organism organism : organisms)
    {  
      organism.show();
      organism.move();

      populationBiomass += organism.mass;

      if (organism.species == PanGenome.Species.Snake)
      {
        snakeCount++;
      } else
      {
        wormCount++;
      }
    }

    println("Total biomass: " + populationBiomass);
    println("Population size : " + organisms.size() + ", (Snakes, Worms): " + "(" + snakeCount +", " + wormCount + ")");
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

      if (babyChance < organism.howFat() * HOW_FAT_TO_MAKE_BABY_MULTIPLIER)
      {
        theBabies.add(organism.makeBaby());
      }
    }

    organisms.addAll(theBabies);
  }

  private void feedingTime()
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

      if (other.species == organism.species) 
      {
        organism.collidingWith = other;
        other.collidingWith = organism;

        continue;
      }

      if (organism.canIEat(other)) {
        organism.chomp(other);
        continue;
      }

      if (other.canIEat(organism)) {
        other.chomp(organism);
        continue;
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
      painter.show(organism1, WHITE, DRAW_OVERLAP);
      painter.show(organism2, WHITE, DRAW_OVERLAP);
    }
    
    return isOverlapping;
  }
}
