import java.util.Random;

enum Species {
  Algae, 
  Fish, 
  Snake
}

class Pangenome
{

  // Genomes
  //private static final SnakeGenome SNAKE = new SnakeGenome();
  //private static final FishGenome FISH = new FishGenome();
  //private static final AlgaeGenome ALGAE = new AlgaeGenome();
  private SnakeGenome SNAKE;
  private FishGenome FISH;
  private AlgaeGenome ALGAE;

  public Pangenome()
  {
    SNAKE = new SnakeGenome();
    FISH = new FishGenome();
    ALGAE = new AlgaeGenome();
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
      switch (species)
      {
        case Snake:
        return SNAKE;
        case Fish:
        return FISH;
        case Algae:
        return ALGAE;
        default:
        return null;
      }
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
  public Species species;

  public Genome(Species _species)
  {
    species = _species;
  }

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

      species = genome.species;
    }

    //private class Nucleotide()
    //{}
  }

  public class Gene
  {
  }

  public Dna createDna()
  {
    return new Dna(this);
  }
}

public class SnakeGenome extends Genome
{
  public SnakeGenome(){
    super(Species.Snake);
  }

  public Dna createDna() {
    Dna dna = new Dna(this);

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
  public FishGenome(){
    super(Species.Fish);
  }

  public Dna createDna() {
    Dna dna = new Dna(this);

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
  public AlgaeGenome(){
    super(Species.Algae);
  }

  public Dna createDna() {
    Dna dna = new Dna(this);

    dna.colour = color(100, 255, 0);
    dna.predatorFactor = 0.0;

    dna.howFatToMakeBaby = 0.5;
    dna.stuffedFactor = 2;

    dna.lowerMassLimit = 1;
    dna.upperMassLimit = 1;

    return dna;
  }
}
