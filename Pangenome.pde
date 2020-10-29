import java.util.Random;

  enum Species {
  Algae, 
    Fish, 
    Snake
}

static class Pangenome
{

  // Genomes
  private static final SnakeGenome SNAKE_GENOME = new SnakeGenome();
  private static final FishGenome FISH_GENOME = new FishGenome();
  private static final AlgaeGenome ALGAE_GENOME = new AlgaeGenome();

  static final List<Species> SPECIES_LIST =
    Collections.unmodifiableList(Arrays.asList(Species.values()));
  private static final Random RANDOM = new Random();

  public static Species randomSpecies()
  {
    return SPECIES_LIST.get(RANDOM.nextInt(SPECIES_LIST.size()));
  }

  public static Genome getGenome(Species species)
  {
    try {
      switch (species)
      {
      case Snake:
        return SNAKE_GENOME;
      case Fish:
        return FISH_GENOME;
      case Algae:
        return ALGAE_GENOME;
      default:
      }


      throw new Exception("Unknown genome: " + species);
    }
    catch(Exception exception)
    {
      System.out.println(exception.getMessage());
    }
    
    return new Genome();
  }
}
