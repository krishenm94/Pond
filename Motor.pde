float COLLISION_DAMPING_FACTOR = 0.5;
float ACCELERATION_NOISE_FACTOR = 15;
float ACCELERATION_GROWTH_FACTOR = 0.45;
float SLITHER_FACTOR = 2;

float TERMINAL_VELOCITY = 2;
float STAGNANT_VELOCITY = 0.5;

class Motor {
  protected Organism self;

  protected PVector displacement;
  protected PVector velocity;
  protected PVector acceleration;
  float timeOffset = random(0, CLOCK_MAX);

  public Motor(Organism organism, PVector startDisplacement, PVector startVelocity) {
    self = organism;
    displacement = startDisplacement;
    velocity = startVelocity;
    acceleration = new PVector(0, 0);
  }

  public void update()
  {
    if (self == null)
    {
      Log.error("Motor has no self.");
      return;
    }

    move();
    clampToCanvas();
    bounceIfOrganismCollision();
    bounceIfWallCollision();
  }

  protected void move()
  {
    updateAcceleration();
    updateVelocity();
    updateDisplacement();
  }

  protected void updateDisplacement() {
    displacement.add(velocity);
  }

  protected void updateVelocity()
  {
    velocity.add(acceleration);
    if ( velocity.mag() > TERMINAL_VELOCITY)
    {
      velocity.div(velocity.mag() / TERMINAL_VELOCITY);
    } else if ( velocity.mag() < STAGNANT_VELOCITY)
    {
      velocity.mult(STAGNANT_VELOCITY / velocity.mag());
    }
  }

  protected void updateAcceleration() {
    PVector accelerationStep = new PVector();

    accelerationStep.add(PVector.random2D().mult(ACCELERATION_NOISE_FACTOR * 12* sin(CLOCK + timeOffset)));
    accelerationStep.div(pow(mass(), 3));

    acceleration.mult(ACCELERATION_GROWTH_FACTOR * 0.5);
    acceleration.add(accelerationStep);
  }

  private float clamp(float input, float lowerLimit, float upperLimit)
  {
    if (input >= upperLimit)
    {
      return upperLimit;
    }

    if (input <= lowerLimit)
    {
      return lowerLimit;
    }

    return input;
  }

  private void clampToCanvas()
  {
    displacement.x = clamp(displacement.x, 0, width);
    displacement.y = clamp(displacement.y, 0, height);
  }

  private void bounceIfWallCollision()
  {
    if (displacement.x == width || displacement.x == 0)
    {
      velocity.x = velocity.x * COLLISION_DAMPING_FACTOR;
      acceleration.x = acceleration.x  * COLLISION_DAMPING_FACTOR;
    }

    if (displacement.y == height || displacement.y == 0 )
    {
      velocity.y = velocity.y * COLLISION_DAMPING_FACTOR;
      acceleration.y = acceleration.y  * COLLISION_DAMPING_FACTOR;
    }
  }

  private void bounceIfOrganismCollision()
  {
    if (self.collidingWith == null)
    {
      return;
    }

    bounceAgainstOther();

    self.collidingWith.collidingWith = null;
    self.collidingWith = null;
  }

  protected void bounceAgainstOther()
  {
    Organism other = self.collidingWith;

    PVector otherToSelfVector = displacement.copy().sub(other.displacement());
    PVector otherToSelfUnitVector = otherToSelfVector.copy().normalize();

    if (DRAW_COLLISION)
    {
      stroke(RED);
      line(displacement.x, 
        displacement.y, 
        displacement.x + (velocity.x * 100), 
        displacement.y + (velocity.y*100));

      stroke(BLUE);
      line(other.displacement().x, 
        other.displacement().y, 
        other.displacement().x + (other.velocity().x * 100), 
        other.displacement().y + (other.velocity().y*100));
    }

    // For proof on perfectly inelastic collision of balls:
    // https://stackoverflow.com/questions/35211114/2d-elastic-ball-collision-physics
    ////////////////////////////////////////////////////////
    PVector newVelocity = otherToSelfUnitVector.copy();
    newVelocity.mult(other.mass * 2 / (other.mass + mass()));
    newVelocity.mult(otherToSelfUnitVector.dot(velocity.copy().sub(other.velocity())));
    newVelocity = velocity.copy().sub(newVelocity);

    PVector selfToOtherUnitVector = otherToSelfUnitVector.copy().mult(-1);
    PVector newOtherVelocity = selfToOtherUnitVector.copy();
    newOtherVelocity.mult(mass() * 2 / (other.mass + mass()));
    newOtherVelocity.mult(selfToOtherUnitVector.dot(other.velocity().copy().sub(velocity)));
    newOtherVelocity = other.velocity().copy().sub(newOtherVelocity);

    velocity = newVelocity;
    other.setVelocity(newOtherVelocity);

    ///////////////////////////////////////////////////////////

    if (DRAW_COLLISION)
    {
      stroke(GREEN);
      line(displacement.x, 
        displacement.y, 
        displacement.x + (velocity.x * 100), 
        displacement.y + (velocity.y*100));

      stroke(MAROON);
      line(other.displacement().x, 
        other.displacement().y, 
        other.displacement().x + (other.velocity().x * 100), 
        other.displacement().y + (other.velocity().y*100));
    }
  }

  float mass()
  {
    return self.mass;
  }
}

public class SnakeMotor extends Motor
{
  PVector velocityNormal;

  public SnakeMotor(Organism organism, PVector startDisplacement, PVector startVelocity) {
    super(organism, startDisplacement, startVelocity);
  }

  protected void updateVelocity() {
    super.updateVelocity();

    velocityNormal = velocity.copy();
    velocityNormal.rotate(90);
    velocityNormal.mult(sin(CLOCK + timeOffset));
    velocityNormal.mult(SLITHER_FACTOR);
  }

  protected void updateDisplacement() {
    super.updateDisplacement();

    displacement.add(velocityNormal);
  }
}

public class FishMotor extends Motor
{
  public FishMotor(Organism organism, PVector startDisplacement, PVector startVelocity) {
    super(organism, startDisplacement, startVelocity);
  }
}

public class AlgaeMotor extends Motor
{
  public AlgaeMotor(Organism organism, PVector startDisplacement, PVector startVelocity) {
    super(organism, startDisplacement, startVelocity);
  }

  protected void bounceAgainstOther()
  {
    if (self.collidingWith.species() == Species.Algae)
    {
      return;
    }

    super.bounceAgainstOther();
  }

  protected void updateAcceleration()
  {
    PVector accelerationStep = velocity.copy();

    //accelerationStep.mult(-1);
    accelerationStep.div(pow(mass(), 3));

    acceleration.mult(ACCELERATION_GROWTH_FACTOR * 0.25);
    acceleration.add(accelerationStep);
  }
}
