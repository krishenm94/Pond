import java.util.Random;

static class Genome
{
  enum Species {
      Worm, 
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
