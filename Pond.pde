int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.05;

float ENTROPY = 0.99;

Population population = new Population();
Painter painter = new Painter();
Pangenome pangenome = new Pangenome();

void setup()
{
  size(600, 600);
  background(BACKGROUND);
  smooth();

  population.init(POPULATION_SIZE);
}

void draw()
{
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
