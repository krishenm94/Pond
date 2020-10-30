boolean BLUR = false;

boolean DRAW_BIRTH = false;
boolean DRAW_DADDY = false;
boolean DRAW_BABY = false;

boolean DRAW_PREDATION = false;
boolean DRAW_DEAD = false;
boolean DRAW_PREDATOR = false;
boolean DRAW_POST_CHOMP_GROWTH = false;

boolean DRAW_ORGANISM = true;

boolean DRAW_OVERLAP = false;

boolean DEBUG_RECT = false;
boolean DEBUG_ELLIPSE = true;

boolean DRAW_COLLISION = false;

color RED = color(255, 0, 0);
color GREEN = color(0, 255, 0);
color BLUE = color(0, 0, 255);
color MAROON = color(255, 0, 255);
color BLACK = 0;
color WHITE = 255;

class Painter
{
  Painter()
  {
  }

  void show(Organism organism)
  {
    if (!DRAW_ORGANISM)
    {
      return;
    }

    //stroke(BLUR? organism.colour: color(0,0,0) , BLUR? 30 : 255);
    stroke(organism.colour , BLUR? 30 : 255);
    fill(organism.colour, BLUR? 20 : 200);

    ellipse(organism.displacement().x, 
      organism.displacement().y, 
      organism.mass, 
      organism.mass);
  }

  void show(Organism organism, color colour, boolean FLAG)
  {
    if (!FLAG)
    {
      return;
    }

    stroke(0);
    fill(colour);

    if (DEBUG_ELLIPSE)
    {

      ellipse(organism.displacement().x
        , organism.displacement().y
        , organism.mass, organism.mass);
    }
 
    if (DEBUG_RECT)
    {
      rect(organism.displacement().x - organism.mass / 2
        , organism.displacement().y - organism.mass / 2
        , organism.mass, organism.mass);
    }
  }

  void show(Organism organism, color colour)
  {
    show(organism, colour, true);
  }
}
