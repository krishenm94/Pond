public class FishGenome extends Genome
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
