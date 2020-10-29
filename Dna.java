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
    float value;
  }
}