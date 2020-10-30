float FISSION_FACTOR = 0.4;
float PROJECTILE_DELIVERY_FACTOR = 1.0;
float MUTATION_CHANCE_BOUNDARY = 0.8;

float MASS_LOWER_LIMIT = 5;
float MASS_UPPER_LIMIT = 30;

float PREDATOR_FACTOR = 0.5;
float TOO_STUFFED_TO_EAT_FACTOR = 5;

float HOW_FAT_TO_MAKE_BABY_MULTIPLIER = 0.05;

class Organism
{
  private Motor motor;
  private Genome.Dna dna;
  private float startMass = random(MASS_LOWER_LIMIT, MASS_UPPER_LIMIT);
  float mass = startMass;

  //private color colour = color(0,0,0,1); 
  private color colour = color(random(0, 255), random(0, 255), random(0, 255));

  boolean isDead = false;
  Organism collidingWith; // TODO: Make this a List

  Species species()
  {
    return dna.species;
  }
  
  boolean canIEat(Organism other)
  {
    return this.mass * PREDATOR_FACTOR > other.mass &&
    !other.isDead && 
    this.mass < this.startMass * TOO_STUFFED_TO_EAT_FACTOR;
  }

  void move()
  {
    motor.update();
  }

  private Organism(PVector displacement, Genome.Dna _dna)
  {
    this(random(MASS_LOWER_LIMIT, MASS_UPPER_LIMIT), displacement, _dna);
  }

  public Organism(float _mass, PVector displacement, Genome.Dna _dna)
  {
    mass = _mass;
    dna = _dna;
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
    return (mass - startMass)/ startMass * HOW_FAT_TO_MAKE_BABY_MULTIPLIER;
  }

  Organism makeBaby()
  {
    painter.show(this, color(0, 255, 255), DRAW_BIRTH);

    PVector displacement = PVector.random2D();
    displacement.mult(this.mass* PROJECTILE_DELIVERY_FACTOR);
    displacement.add(this.displacement());
    
    Organism baby = new Organism(this.mass * FISSION_FACTOR, displacement, this.dna);
    
    baby.setVelocity(baby.velocity().mult(PROJECTILE_DELIVERY_FACTOR));
    
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
