class Organism
{
  private Genome genome;
  private Genome.Dna dna;
  
  private Motor motor;
  private Appearance appearance;
  private Senses senses;

  private float startMass;
  float mass = startMass;
  float age = 0;

  public color randomColour =  painter.randomColour();
  private color colour;

  boolean isDead = false;
  ArrayList<Organism> collidingWith = new ArrayList<Organism>();

  Species species()
  {
    return dna.species;
  }

  boolean canIEat(Organism other)
  {
    return this.mass * dna.predatorFactor > other.mass &&
      !other.isDead && 
      this.mass < this.startMass * dna.maxFoodCapacityCoefficient &&
      genome.diet.contains(other.species());
  }

  void update()
  {
    age += CLOCK_INCREMENT;
    mass -= CLOCK_INCREMENT * dna.metabolicRate / ENTROPY;

    if (mass < startMass /dna.emaciationQuotient)
    { 
      isDead = true;
      return;
    }

    if (age > dna.maxAge)
    {
      isDead = true;
    }

    motor.update();
  }

  private Organism(PVector displacement, Genome _genome)
  {
    genome = _genome;
    dna = genome.createDna();
    
    startMass = random(dna.lowerMassLimit, dna.upperMassLimit);
    mass = startMass;
    colour = dna.colour;
    
    motor = genome.createMotor(this, displacement, PVector.random2D());
    appearance = genome.createAppearance(this, dna.colour);
    senses = genome.createSenses(this);
  }

  public void show()
  {
    appearance.show();
  }

  void chomp(Organism other)
  {
    mass = (this.mass + other.mass) * ENTROPY;
    other.isDead = true;

    painter.show(this, color( 0, 255, 0), DRAW_PREDATION || DRAW_POST_CHOMP_GROWTH);

    mass = this.mass - other.mass;

    painter.show(this, color(255, 0, 0), DRAW_PREDATION || DRAW_PREDATOR);

    mass = this.mass + other.mass;

    painter.show(other, color(255), DRAW_PREDATION || DRAW_DEAD);
  }

  PVector displacement()
  {
    return motor.displacement;
  }

  void setDisplacement(PVector vector)
  {
    motor.displacement = vector;
  }

  PVector velocity()
  {
    return motor.velocity;
  }

  void setVelocity(PVector vector)
  {
    motor.velocity = vector;
  }

  PVector acceleration()
  {
    return motor.acceleration;
  }

  void setAcceleration(PVector vector)
  {
    motor.acceleration = vector;
  }

  float howFat()
  {
    return (mass - startMass)/ startMass * dna.fertility;
  }

  Organism makeBaby()
  {
    painter.show(this, color(0, 255, 255), DRAW_BIRTH);

    PVector displacement = PVector.random2D();
    displacement.mult(this.mass);
    displacement.add(this.displacement());

    Organism baby = new Organism(displacement, this.genome);
    baby.mass = this.mass * dna.fissionFactor *ENTROPY;
    baby.setVelocity(baby.velocity());

    this.mass = (this.mass - baby.mass/ENTROPY) * ENTROPY;

    painter.show(this, color(0, 70, 180), DRAW_BIRTH || DRAW_DADDY);
    painter.show(baby, color(0, 150, 25), DRAW_BIRTH || DRAW_BABY);

    return baby;
  }

  float timeOffset()
  {
    return motor.timeOffset;
  }

  void photosynthesise()
  {
    if (dna.photosynthesisIncrement <= 0)
    {
      return;
    }

    mass += dna.photosynthesisIncrement;
  }

  float maxMass()
  {
    return startMass*dna.maxFoodCapacityCoefficient;
  }
}
