import java.util.Random;

enum Species {
  Algae, 
    Fish, 
    Snake
}

public static class Pangenome
{

  static final List<Species> SPECIES_LIST =
    Collections.unmodifiableList(Arrays.asList(Species.values()));
  private static final Random RANDOM = new Random();

  public static Species randomSpecies()
  {
    return SPECIES_LIST.get(RANDOM.nextInt(SPECIES_LIST.size()));
  }

  // Genomes
  private static final SnakeGenome SNAKE_GENOME = new SnakeGenome();
  private static final FishGenome FISH_GENOME = new FishGenome();
  private static final AlgaeGenome ALGAE_GENOME = new AlgaeGenome();

  public static Genome getGenome(Species species)
  {
    switch (species)
    {
    case Species.Snake:
      return SNAKE_GENOME;
    case Species>Fish:
      return FISH_GENOME;
    case Species.Algae:
      return ALGAE_GENOME;
    }

    throw new Exception("Unknown genome: " + species);
  }
}

// TODO: Create subclasses of `Genome` to 
// implement different `Gene` combinations
class Genome
{

  public Dna create()
  {
    return new Dna();
  }
}

class SnakeGenome extends Genome
{
  public Dna create() {
    Dna dna = new Dna();

    dna.species = Species.Snake;

    dna.colour = color(255, 100, 0);
    dna.predatorFactor = 0.8;

    dna.reproductionMultiplier = 0.05;
    dna.stuffedFactor = 8;

    dna.lowerMassLimit = 10;
    dna.upperMassLimit = 25;

    return dna;
  }
}

class FishGenome extends Genome
{
  public Dna create() {
    Dna dna = new Dna();

    dna.species = Species.Fish;

    dna.colour = color(0, 100, 255);
    dna.predatorFactor = 0.5;

    dna.reproductionMultiplier = 0.05;
    dna.stuffedFactor = 5;

    dna.lowerMassLimit = 5;
    dna.upperMassLimit = 15;

    return dna;
  }
}
}

class AlgaeGenome extends Genome
{
  public Dna create() {
    Dna dna = new Dna();

    dna.species = Species.Algae;

    dna.colour = color(100, 255, 0);
    dna.predatorFactor = 0.0;

    dna.reproductionMultiplier = 0.5;
    dna.stuffedFactor = 2;

    dna.lowerMassLimit = 1;
    dna.upperMassLimit = 1;

    return dna;
  }
}
}

class Gene
{
  float value;
}

class Dna
{
  Species species;

  private color colour;
  private float predatorFactor;

  private int reproductionMultiplier;
  private int stuffedFactor;

  private float lowerMassLimit;
  private float upperMassLimit;

  public Dna()
  {
  }
}
