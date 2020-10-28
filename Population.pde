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
    add(new Organism());
  }

  public void update()
  {
    feedingTime();
    babyTime();

    //int speciesCount = 0;
    int wormCount = 0;
    int snakeCount = 0;
    float populationBiomass = 0;
    for (Organism organism : organisms)
    {  
      organism.show();
      organism.move();

      populationBiomass += organism.mass;

      if (organism.species == Genome.Species.Snake)
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

  boolean areMeeting(Organism org1, Organism org2)
  {
    float left1 = org1.displacement().x - org1.mass/2;
    float right1 = org1.displacement().x + org1.mass/2;
    float top1 = org1.displacement().y - org1.mass/2;
    float bottom1 = org1.displacement().y + org1.mass/2;

    float left2 = org2.displacement().x - org2.mass/2;
    float right2 = org2.displacement().x + org2.mass/2;
    float top2 = org2.displacement().y - org2.mass/2;
    float bottom2 = org2.displacement().y + org2.mass/2;

    if (left1 > right2 || left2 > right1 ||
      top1 > bottom2 || top2 > bottom1)
    {
      return false;
    }

    float xOverlapL1R2 = left1 - right2;
    float xOverlapR2L1 = left2 - right1;
    float yOverlapT2B1 = top2 - bottom1;
    float yOverlapT1B2 = top1 - bottom2;

    // TODO: Use mass to determine ratio

    if (xOverlapL1R2 < 0)
    {
      org1.displacement().add(xOverlapL1R2/2, 0);
      org2.displacement().add(-xOverlapL1R2/2, 0);
    } 
    if (xOverlapR2L1 < 0)
    {
      org1.displacement().add(-xOverlapR2L1/4, 0);
      org2.displacement().add(xOverlapR2L1/4, 0);
    }  
    if (yOverlapT2B1 < 0)
    {
      org1.displacement().add(0, -yOverlapT2B1/4);
      org2.displacement().add(0, yOverlapT2B1/4);
    } 
    if (yOverlapT1B2 < 0)
    {
      org1.displacement().add(0, yOverlapT1B2/4);
      org2.displacement().add(0, -yOverlapT1B2/4);
    }

    return true;
  }

  //  private void moveOutOfOverlap()
  //{
  //  float xOverlap = 
  //}
}
