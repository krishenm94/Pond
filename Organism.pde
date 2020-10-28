float FISSION_FACTOR = 0.4;
float PROJECTILE_DELIVERY_FACTOR = 1.0;
float MUTATION_CHANCE_BOUNDARY = 0.8;
float EDIBILITY_FACTOR = 0.5;

float MASS_LOWER_LIMIT = 10;
float MASS_UPPER_LIMIT = 50;

float PREDATOR_FACTOR = 0.9;
float TOO_STUFFED_TO_EAT_FACTOR = 5;

class Organism
{
  private Motor motor;
  private float startMass = random(MASS_LOWER_LIMIT, MASS_UPPER_LIMIT);
  float mass = startMass;
  private color colour = color(random(0, 255), random(0, 255), random(0, 255));

  boolean isDead = false;
  Genome.Species species = Genome.random();
  Organism collidingWith; // Make this a List

  boolean canIEat(Organism other)
  {
    return this.mass * PREDATOR_FACTOR > other.mass;
  }

  void move()
  {
    motor.update();
  }

  public Organism(PVector displacement, color _colour)
  {
    init(displacement);
    colour = _colour;
  }

  public Organism()
  {
    PVector displacement = new PVector();
    displacement.x = random(0, width);
    displacement.y = random(0, height);

    init(displacement);
  }

  private void init(PVector displacement)
  {
    motor = new Motor(this, displacement, PVector.random2D());
  }

  public void show()
  {
    paint.show(this);
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

    paint.show(this, color( 0, 255, 0), DRAW_PREDATION || DRAW_POST_CHOMP_GROWTH);

    mass = this.mass - other.mass;
    paint.show(this, color(255, 0, 0), DRAW_PREDATION || DRAW_PREDATOR);
    mass = this.mass + other.mass;

    paint.show(other, color(255), DRAW_PREDATION || DRAW_DEAD);
  }

  PVector displacement()
  {
    return motor.displacement;
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
    PVector displacement = PVector.random2D();

    float newMass = mass * (1 - FISSION_FACTOR);

    displacement.mult(newMass * PROJECTILE_DELIVERY_FACTOR);
    displacement.add(this.displacement());

    color childColour = colour;
    if ( MUTATION_CHANCE_BOUNDARY < random(0, 1))
    {
      childColour = color(random(0, 255), random(0, 255), random(0, 255));
    } 

    paint.show(this, color(0, 255, 255), DRAW_BIRTH);

    Organism baby = new Organism(displacement, childColour);
    baby.setVelocity(baby.velocity().mult(PROJECTILE_DELIVERY_FACTOR));
    baby.mass = mass * FISSION_FACTOR;
    baby.species = this.species;
    this.mass = mass - baby.mass;

    paint.show(this, color(0, 70, 180), DRAW_BIRTH || DRAW_DADDY);
    paint.show(baby, color(0, 150, 25), DRAW_BIRTH || DRAW_BABY);

    return baby;
  }

  float timeOffset()
  {
    return motor.timeOffset;
  }
}
