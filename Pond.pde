int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.1;

static int POPULATION_SIZE = 100;

boolean BLUR = true;

Population population = new Population();
Painter painter = new Painter();
Pangenome pangenome = new Pangenome();

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
