public class SnakeGenome extends Genome
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
