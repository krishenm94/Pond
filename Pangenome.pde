import java.util.Random;

enum Species {
  Algae, 
    Fish, 
    Snake
}

class Pangenome
{

  // Genomes
  //private static final SnakeGenome SNAKE_GENOME = new SnakeGenome();
  //private static final FishGenome FISH_GENOME = new FishGenome();
  //private static final AlgaeGenome ALGAE_GENOME = new AlgaeGenome();
  private SnakeGenome SNAKE_GENOME;
  private FishGenome FISH_GENOME;
  private AlgaeGenome ALGAE_GENOME;

  public Pangenome()
  {
    SNAKE_GENOME = new SnakeGenome();
    FISH_GENOME = new FishGenome();
    ALGAE_GENOME = new AlgaeGenome();
  }

  final List<Species> SPECIES_LIST =
    Collections.unmodifiableList(Arrays.asList(Species.values()));
  private final Random RANDOM = new Random();

  public Species randomSpecies()
  {
    return SPECIES_LIST.get(RANDOM.nextInt(SPECIES_LIST.size()));
  }

  public Genome getGenome(Species species)
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
    // Move catch to a higher level
    catch(Exception exception)
    {
      System.out.println(exception.getMessage());
    }

    return new Genome();
  }
  
  public Genome randomGenome()
  {
    return getGenome(randomSpecies());
  }
}

////// Genomes

// TODO: Introduce mutation factor
public class Genome
{
  // TODO: Implement Dna as a map of template typed genes
  public class Dna
  {
    Species species;

    // TODO: KM: These should be genes and private
    public color colour;
    public float predatorFactor;

    public float howFatToMakeBaby;
    public int stuffedFactor;

    public float lowerMassLimit;
    public float upperMassLimit;

    public Dna(Genome genome)
    {
      Objects.requireNonNull(genome);
    }

    public class Gene
    {
    }
  }

  public Dna create()
  {
    return new Dna(this);
  }
}

public class SnakeGenome extends Genome
{
  public Dna create() {
    Dna dna = new Dna(this);

    dna.species = Species.Snake;

    dna.colour = color(255, 100, 0);
    dna.predatorFactor = 0.8;

    dna.howFatToMakeBaby = 0.05;
    dna.stuffedFactor = 8;

    dna.lowerMassLimit = 10;
    dna.upperMassLimit = 25;

    return dna;
  }
}

public class FishGenome extends Genome
{
  public Dna create() {
    Dna dna = new Dna(this);

    dna.species = Species.Fish;

    dna.colour = color(0, 100, 255);
    dna.predatorFactor = 0.5;

    dna.howFatToMakeBaby = 0.05;
    dna.stuffedFactor = 5;

    dna.lowerMassLimit = 5;
    dna.upperMassLimit = 15;

    return dna;
  }
}

public class AlgaeGenome extends Genome
{
  public Dna create() {
    Dna dna = new Dna(this);

    dna.species = Species.Algae;

    dna.colour = color(100, 255, 0);
    dna.predatorFactor = 0.0;

    dna.howFatToMakeBaby = 0.5;
    dna.stuffedFactor = 2;

    dna.lowerMassLimit = 1;
    dna.upperMassLimit = 1;

    return dna;
  }
}
