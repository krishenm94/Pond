class Organism
{
  private Motor motor;
  private Genome.Dna dna;
  private float startMass;
  float mass = startMass;

  private color colour;

  boolean isDead = false;
  Organism collidingWith; // TODO: Make this a List

  Species species()
  {
    return dna.species;
  }

  boolean canIEat(Organism other)
  {
    return this.mass * dna.predatorFactor > other.mass &&
      !other.isDead && 
      this.mass < this.startMass * dna.stuffedFactor;
  }

  void move()
  {
    motor.update();
  }

  private Organism(PVector displacement, Genome.Dna _dna)
  {
    this(random(_dna.lowerMassLimit, _dna.upperMassLimit), displacement, _dna);
  }

  public Organism(float _mass, PVector displacement, Genome.Dna _dna)
  {
    dna = _dna;
    
    mass = _mass;
    startMass = random(dna.lowerMassLimit, dna.upperMassLimit);
    colour = dna.colour;
    
    motor = new Motor(this, displacement, PVector.random2D());
  }

  public void show()
  {
    painter.show(this);
  }

  void chomp(Organism other)
  {
    mass = this.mass + other.mass;
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
    return (mass - startMass)/ startMass * dna.howFatToMakeBaby;
  }

  Organism makeBaby()
  {
    painter.show(this, color(0, 255, 255), DRAW_BIRTH);

    PVector displacement = PVector.random2D();
    displacement.mult(this.mass);
    displacement.add(this.displacement());

    Organism baby = new Organism(this.mass * dna.fissionFactor, displacement, this.dna);

    baby.setVelocity(baby.velocity());

    this.mass = this.mass - baby.mass;

    painter.show(this, color(0, 70, 180), DRAW_BIRTH || DRAW_DADDY);
    painter.show(baby, color(0, 150, 25), DRAW_BIRTH || DRAW_BABY);

    return baby;
  }

  float timeOffset()
  {
    return motor.timeOffset;
  }
}
