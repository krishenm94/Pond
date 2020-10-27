float FISSION_FACTOR = 0.4;
float PROJECTILE_DELIVERY_FACTOR = 1.0;
float MUTATION_CHANCE_BOUNDARY = 0.8;
float EDIBILITY_FACTOR = 0.5;

float MASS_LOWER_LIMIT = 5;
float MASS_UPPER_LIMIT = 20;

boolean DRAW_BIRTH = false;
boolean DRAW_DADDY = false;
boolean DRAW_BABY = false;

boolean DRAW_DEAD = false;
boolean DRAW_PREDATOR = false;

boolean DRAW_ORGANISM = true;

enum Species {
  Fish,
  Snake
}

class Organism
{
  protected Mover mover;
  private float startMass = random(MASS_LOWER_LIMIT, MASS_UPPER_LIMIT);
  protected color colour = color(random(0, 255), random(0, 255), random(0, 255));
  boolean isDead = false;
  Species species = Species.Fish;

  boolean isSmallerThan(Organism other)
  {
    return this.mass() * 0.5 < other.mass();
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
    mover = new Mover(random(10, 35), displacement, PVector.random2D());
  }

  public void show()
  {
    if (!DRAW_ORGANISM)
    {
      return;
    }
    stroke(colour, 40);
    fill(colour, 20);
    ellipse(mover.displacement.x, mover.displacement.y, mass(), mass());
  }

  void chomp(Organism other)
  {
    if (other.isDead || this.mass() > startMass * 5)
    {
      return;
    }

    this.setMass(this.mass() + other.mass());
    other.isDead = true;

    if (DRAW_PREDATOR)
    {
      stroke(0);
      fill(255, 0, 0);
      rect(this.displacement().x, this.displacement().y, this.mass(), this.mass());
    }

    if (DRAW_DEAD)
    {
      stroke(255);
      fill(0);
      rect(other.displacement().x, other.displacement().y, other.mass(), other.mass());
    }
  }

  PVector displacement()
  {
    return mover.displacement;
  }

  PVector velocity()
  {
    return mover.velocity;
  }

  void setVelocity(PVector vector)
  {
    mover.velocity = vector;
  }

  PVector acceleration()
  {
    return mover.acceleration;
  }

  void setAcceleration(PVector vector)
  {
    mover.acceleration = vector;
  }

  float howFat()
  {
    return (mass() - startMass)/ startMass;
  }

  float mass()
  {
    return mover.mass;
  }

  void setMass(float mass)
  {
    mover.mass = mass;
  }

  Organism makeBaby()
  {
    PVector displacement = PVector.random2D();

    float newMass = mass() * (1 - FISSION_FACTOR);

    displacement.mult(newMass * PROJECTILE_DELIVERY_FACTOR);
    displacement.add(this.displacement());

    color childColour = colour;
    if ( MUTATION_CHANCE_BOUNDARY < random(0, 1))
    {
      childColour = color(random(0, 255), random(0, 255), random(0, 255));
    } 
    
    if (DRAW_BIRTH)
    {
      stroke(0, 255, 255);
      fill(0, 255, 255);
      rect(this.displacement().x, this.displacement().y, this.mass(), this.mass());
    }

    Organism baby = new Organism(displacement, childColour);
    baby.setVelocity(baby.velocity().mult(PROJECTILE_DELIVERY_FACTOR));
    baby.setMass(mass() * FISSION_FACTOR);
    this.setMass(mass() - baby.mass());

    if (DRAW_DADDY)
    {
      stroke(0, 255, 0);
      fill(0, 70, 180);
      rect(this.displacement().x, this.displacement().y, this.mass(), this.mass());
    }

    if (DRAW_BABY)
    {
      stroke(0, 0, 100);
      fill(0, 150, 25);
      rect(baby.displacement().x, baby.displacement().y, baby.mass(), baby.mass());
    }

    return baby;
  }
}
