int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.1;

static int WIDTH = 500;
static int HEIGHT = 500;

static int POPULATION_SIZE = 10;

boolean BLUR = false;

Population population = new Population();
Painter painter = new Painter();

void setup()
{
  size(500, 500);
  background(BACKGROUND);
  smooth();

  population.init(POPULATION_SIZE);
}

void draw()
{
  if (!BLUR)
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
