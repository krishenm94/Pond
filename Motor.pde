float COLLISION_DAMPING_FACTOR = -0.5;
float ACCELERATION_NOISE_FACTOR = 15;      
float ACCELERATION_GROWTH_FACTOR = 0.90;
float SLITHER_FACTOR = 1.5;

float TERMINAL_VELOCITY = 3;
float STAGNANT_VELOCITY = 1;

class Motor {
  private Organism body;
  float mass;
  PVector displacement;
  PVector velocity;
  PVector acceleration;
  float timeOffset = random(0, CLOCK_MAX);

  public Motor(float startMass, PVector startDisplacement, PVector startVelocity)
  {
    mass = startMass;
    displacement = startDisplacement;
    velocity = startVelocity;
    acceleration = new PVector(0, 0);

    engine.add(this);
  }

  public void update()
  {
    velocity.add(acceleration);

    if ( velocity.mag() > TERMINAL_VELOCITY)
    {
      velocity.div(velocity.mag() / TERMINAL_VELOCITY);
    } else if ( velocity.mag() < STAGNANT_VELOCITY)
    {
      velocity.mult(STAGNANT_VELOCITY / velocity.mag());
    }

    PVector velocityNormal = new PVector(velocity.x, velocity.y);
    velocityNormal.rotate(90);
    velocityNormal.mult(sin(CLOCK + timeOffset));
    velocityNormal.mult(SLITHER_FACTOR);

    // ALGAE GROWTH ALGORITHM?
    //velocity.x *= sin(velocity.y * CLOCK) * 1.7;
    //velocity.y *= sin(velocity.x * CLOCK) * 1.7;
    displacement.add(velocity);
    displacement.add(velocityNormal);

    PVector accelerationStep = new PVector();

    accelerationStep.add(PVector.random2D().mult(ACCELERATION_NOISE_FACTOR));
    accelerationStep.div(pow(mass, 3));

    acceleration.mult(ACCELERATION_GROWTH_FACTOR);
    acceleration.add(accelerationStep);

    clampToCanvas();
    bounceIfColliding();
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

  private void bounceIfColliding()
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

  float mass()
  {
    return body.mass;
  }
}
