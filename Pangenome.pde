import java.util.Random;

static class Genome
{
  enum Species {
    Algae, 
      Fish, 
      Snake
  }

  static final List<Species> GENOME =
    Collections.unmodifiableList(Arrays.asList(Species.values()));
  private static final Random RANDOM = new Random();

  static Species random()
  {
    return GENOME.get(RANDOM.nextInt(GENOME.size()));
  }
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
