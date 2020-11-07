color BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.05;

float ENTROPY = 0.99;

Population population;
Painter painter = new Painter();

void setup()
{
  size(1200, 400, P2D);
  background(BACKGROUND);
  smooth();

  population = new Population();
}

void draw()
{
  blendMode(ADD);
  blendMode(BLEND);
  
  if (!BLUR && !PRETTY)
  {
    background(BACKGROUND);
  }

  population.update();

  drawMouse();

  CLOCK += CLOCK_INCREMENT;
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
