float COLLISION_DAMPING_FACTOR = -0.9;
float ACCELERATION_NOISE_FACTOR = 15;
float ACCELERATION_GROWTH_FACTOR = 0.45;
float SLITHER_FACTOR = 2;

float TERMINAL_VELOCITY = 1.0;
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

    bounceIfOrganismCollision();
    bounceIfWallCollision();

    move();

    clampToWall();
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

  private void clampToWall()
  {
    displacement.x = clamp(displacement.x, 0, width);
    displacement.y = clamp(displacement.y, 0, height);
  }

  protected void bounceIfWallCollision()
  {
    if (displacement.x >= width || displacement.x <= 0)
    {
      velocity.x = velocity.x * COLLISION_DAMPING_FACTOR;
      acceleration.x = acceleration.x  * COLLISION_DAMPING_FACTOR;
      return;
    }

    if (displacement.y >= height || displacement.y <= 0 )
    {
      velocity.y = velocity.y * COLLISION_DAMPING_FACTOR;
      acceleration.y = acceleration.y  * COLLISION_DAMPING_FACTOR;
    }
  }

  private void bounceIfOrganismCollision()
  {
    if (self.collidingWith.isEmpty())
    {
      return;
    }

    for (Organism other : self.collidingWith)
    {
      moveOutOfOverlap(other);
      bounceAgainstOther(other);
      other.collidingWith.remove(self);
    }

    self.collidingWith = new ArrayList<Organism>();
  }

  private void moveOutOfOverlap(Organism other)
  {
    PVector selfToOtherVector = other.displacement().copy().sub(self.displacement()); 

    PVector xUnitVector = selfToOtherVector.copy().normalize();
    // Find edge points along difference vector of displacements

    PVector selfRightEdgePoint = self.displacement().copy().add(xUnitVector.copy().mult(self.mass/2));
    PVector otherLeftEdgePoint = other.displacement().copy().sub(xUnitVector.copy().mult(other.mass/2));
    PVector otherLeftEdgeToSelfRightEdge = selfRightEdgePoint.copy().sub(otherLeftEdgePoint);

    float otherWeight = pow(self.mass, 3);
    float selfWeight = pow(other.mass, 3);

    float totalWeight = selfWeight + otherWeight;
    selfWeight /= totalWeight;
    otherWeight /= totalWeight;

    self.displacement().sub(otherLeftEdgeToSelfRightEdge.mult(selfWeight));
    other.displacement().add(otherLeftEdgeToSelfRightEdge.mult(otherWeight));
  }

  protected void bounceAgainstOther(Organism other)
  {

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
  PVector velocityPropagation;

  void setVelocityPropagation(PVector vector)
  {
    velocityPropagation = vector;
  }

  public SnakeMotor(Organism organism, PVector startDisplacement, PVector startVelocity) {
    super(organism, startDisplacement, startVelocity);
    velocityPropagation = startVelocity.copy();
  }

  protected void updateVelocity() {
    velocityPropagation.add(acceleration);

    velocityNormal = velocityPropagation.copy();
    velocityNormal.rotate(90);
    velocityNormal.mult(sin(CLOCK + timeOffset));
    velocityNormal.mult(SLITHER_FACTOR);

    velocity = velocityPropagation.copy().add(velocityNormal);

    if ( velocity.mag() > TERMINAL_VELOCITY * 2)
    {
      velocity.div(velocity.mag() / TERMINAL_VELOCITY / 2);
    } else if ( velocity.mag() < STAGNANT_VELOCITY * 2)
    {
      velocity.mult(STAGNANT_VELOCITY * 2 / velocity.mag());
    }
  }

  protected void bounceIfWallCollision()
  {
    if (displacement.x >= width || displacement.x <= 0)
    {
      velocityPropagation.x = velocity.x * COLLISION_DAMPING_FACTOR;
      acceleration.x = acceleration.x  * COLLISION_DAMPING_FACTOR;
      return;
    }

    if (displacement.y >= height || displacement.y <= 0 )
    {
      velocityPropagation.y = velocity.y * COLLISION_DAMPING_FACTOR;
      acceleration.y = acceleration.y  * COLLISION_DAMPING_FACTOR;
    }
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

  protected void updateVelocity()
  {
    velocity.add(acceleration);

    if (velocity.mag() == 0.f)
    {
      return;
    }

    // TODO: Make this a gene
    float ALGAE_BE_SLOW = 0.2;

    if ( velocity.mag() > TERMINAL_VELOCITY * ALGAE_BE_SLOW)
    {
      velocity.div(velocity.mag() / TERMINAL_VELOCITY / ALGAE_BE_SLOW);
    } else if ( velocity.mag() < STAGNANT_VELOCITY * ALGAE_BE_SLOW)
    {
      velocity.mult(STAGNANT_VELOCITY * ALGAE_BE_SLOW / velocity.mag());
    }
  }

  protected void bounceAgainstOther(Organism other)
  {
    if (other.species() == Species.Algae)
    {
      agglutinate(other);
      return;
    }

    super.bounceAgainstOther(other);
  }

  private void agglutinate(Organism other)
  {
    PVector velocityCopy = velocity.copy();
    PVector accelerationCopy = acceleration.copy();
    velocity.add(other.velocity()).div(2);
    acceleration.add(other.acceleration()).div(2);
    other.velocity().add(velocityCopy).div(2);
    other.acceleration().add(accelerationCopy).div(2);

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

  protected void updateAcceleration()
  {
    PVector accelerationStep = velocity.copy();
    accelerationStep.mult(-1);

    // PVector selfToMouseVector = (new PVector(mouseX, mouseY)).sub(displacement);
    // selfToMouseVector.normalize();
    // accelerationStep.add(selfToMouseVector);

    accelerationStep.div(pow(mass(), 3));

    acceleration.mult(ACCELERATION_GROWTH_FACTOR * 0.1);
    acceleration.add(accelerationStep);
  }
}
