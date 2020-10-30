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
  private SnakeGenome SNAKE = new SnakeGenome();
  private FishGenome FISH = new FishGenome();
  private AlgaeGenome ALGAE = new AlgaeGenome();

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
      Log.error("Null genome for species: " + species.name());
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

  public Motor createMotor(Organism organism, PVector startDisplacement, PVector startVelocity){
    return null;
  }

    public Dna createDna()
  {
    return new Dna(this);
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

    public float fissionFactor;

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


}

public class SnakeGenome extends Genome
{
  public SnakeGenome() {
    super(Species.Snake);
  }

   public Motor createMotor(Organism organism, PVector startDisplacement, PVector startVelocity){
    return new SnakeMotor(organism, startDisplacement, startVelocity);
  }


  public Dna createDna() {
    Dna dna = new Dna(this);

    dna.colour = color(255, 100, 0);
    dna.predatorFactor = 0.8;

    dna.howFatToMakeBaby = 0.05;
    dna.stuffedFactor = 8;

    dna.lowerMassLimit = 10;
    dna.upperMassLimit = 25;

    dna.fissionFactor = 0.4;

    return dna;
  }
}

public class FishGenome extends Genome
{
  public FishGenome() {
    super(Species.Fish);
  }

    public Motor createMotor(Organism organism, PVector startDisplacement, PVector startVelocity){
    return new FishMotor(organism, startDisplacement, startVelocity);
  }


  public Dna createDna() {
    Dna dna = new Dna(this);

    dna.colour = color(0, 100, 255);
    dna.predatorFactor = 0.5;

    dna.howFatToMakeBaby = 0.05;
    dna.stuffedFactor = 5;

    dna.lowerMassLimit = 5;
    dna.upperMassLimit = 15;

    dna.fissionFactor = 0.2;

    return dna;
  }
}

public class AlgaeGenome extends Genome
{
  public AlgaeGenome() {
    super(Species.Algae);
  }

  public Motor createMotor(Organism organism, PVector startDisplacement, PVector startVelocity){
    return new AlgaeMotor(organism, startDisplacement, startVelocity);
  }


  public Dna createDna() {
    Dna dna = new Dna(this);

    dna.colour = color(100, 255, 0);
    dna.predatorFactor = 0.0;

    dna.howFatToMakeBaby = 0.5;
    dna.stuffedFactor = 2;

    dna.lowerMassLimit = 1;
    dna.upperMassLimit = 1;

    dna.fissionFactor = 0.5;

    return dna;
  }
}
