int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.1;

boolean BLUR = true;

Population population = new Population();
Painter painter = new Painter();

void setup()
{
  size(1200, 500);
  background(BACKGROUND);
  smooth();

  population.init(600);
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
