package processing.core;

// TODO: Introduce mutation factor
public class Genome
{
  public Dna create()
  {
    return new Dna(this);
  }
}
