int BACKGROUND = 255;
float CLOCK = 0;
float CLOCK_MAX = 360;
float CLOCK_INCREMENT = 0.1;

Population population = new Population();
Paint paint = new Paint();

void setup()
{
  size(1500, 500);
  background(BACKGROUND);
  smooth();

  population.init(100);
}

void draw()
{
  //background(BACKGROUND);

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
  } 
  else
  {
    stroke(0);
    fill(0);
  }

  if (mousePressed)
  {
    ellipse(mouseX, mouseY, 50, 50);
  }
}
