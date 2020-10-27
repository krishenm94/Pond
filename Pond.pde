int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.1;

Engine engine = new Engine();
Population population = new Population();
Paint paint = new Paint();

void setup()
{
  size(1500, 500);
  background(BACKGROUND);
  smooth();

  population.init(200);
}

void draw()
{
  //background(BACKGROUND);

  engine.update();
  population.update();

  drawMouse();

  CLOCK += CLOCK_INCREMENT;
  CLOCK %= CLOCK_MAX;
}

void drawMouse()
{
  if (mouseButton == LEFT)
  {
    stroke(255);
    fill(255);
  } else
  {
    stroke(0);
    fill(0);
  }

  if (mousePressed)
  {
    ellipse(mouseX, mouseY, 50, 50);
  }
}
