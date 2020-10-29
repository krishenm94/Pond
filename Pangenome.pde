import java.util.Random;

  enum Species {
  Algae, 
  Fish, 
  Snake
}

static class Pangenome
{

  static final List<Species> SPECIES_LIST =
  Collections.unmodifiableList(Arrays.asList(Species.values()));
  private static final Random RANDOM = new Random();

  static Species randomSpecies()
  {
    return SPECIES_LIST.get(RANDOM.nextInt(SPECIES_LIST.size()));
  }
}

// TODO: Create subclasses of `Genome` to 
// implement different `Gene` combinations
static class Genome
{

}

class Gene
{
  float value;  
}

class DNA
{
  private color colour;
  float predatorFactor;
  
  int reproductionMultiplier;
  int maturityFactor;
  float fullnessMultiplier;
  
  float lowerMassLimit;
  float upperMassLimit;
  
  public DNA()
  {
  }
}
