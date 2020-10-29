float FISSION_FACTOR = 0.4;
float PROJECTILE_DELIVERY_FACTOR = 1.0;
float MUTATION_CHANCE_BOUNDARY = 0.8;

float MASS_LOWER_LIMIT = 5;
float MASS_UPPER_LIMIT = 20;

float PREDATOR_FACTOR = 0.5;
float TOO_STUFFED_TO_EAT_FACTOR = 5;

class Organism
{
  private Motor motor;
  private float startMass = random(MASS_LOWER_LIMIT, MASS_UPPER_LIMIT);
  float mass = startMass;
  private color colour;

  boolean isDead = false;
  Species species;
  Organism collidingWith; // TODO: Make this a List

  boolean canIEat(Organism other)
  {
    return this.mass * PREDATOR_FACTOR > other.mass;
  }

  void move()
  {
    motor.update();
  }

  private Organism(PVector displacement, Species _species)
  {
    this(random(MASS_LOWER_LIMIT, MASS_UPPER_LIMIT), displacement, _species);
  }

  public Organism(float _mass, PVector displacement, Species _species)
  {
    mass = _mass;
    species = _species;
    motor = new Motor(this, displacement, PVector.random2D());
  }

  public void show()
  {
    painter.show(this);
  }

  void chomp(Organism other)
  {
    if (other.isDead ||
      this.mass > this.startMass * TOO_STUFFED_TO_EAT_FACTOR)
    {
      return;
    }

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
    return (mass - startMass)/ startMass;
  }

  Organism makeBaby()
  {
    painter.show(this, color(0, 255, 255), DRAW_BIRTH);

    PVector displacement = PVector.random2D();
    displacement.mult(this.mass* PROJECTILE_DELIVERY_FACTOR);
    displacement.add(this.displacement());
    
    Organism baby = new Organism(this.mass * FISSION_FACTOR, displacement, this.species);
    
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
