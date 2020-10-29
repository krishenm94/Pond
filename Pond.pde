int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.1;

static int POPULATION_SIZE = 400;

boolean BLUR = false;

Population population = new Population();
Painter painter = new Painter();

void setup()
{
  size(500, 500);
  background(BACKGROUND);
  smooth();

  PVector x = new PVector(1, 0);
  PVector v135 = new PVector(-1, 1);
  PVector v225 = new PVector(-1, -1);
  
  float th135 =PVector.angleBetween(v135, x);
  float th225 =PVector.angleBetween(v225, x);
  
  println("th135: " + degrees(th135));
  println("th225: " + degrees(th225));
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
