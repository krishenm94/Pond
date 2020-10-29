public class AlgaeGenome extends Genome
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
