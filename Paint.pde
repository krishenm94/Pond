boolean DRAW_BIRTH = false;
boolean DRAW_DADDY = false;
boolean DRAW_BABY = false;

boolean DRAW_PREDATION = false;
boolean DRAW_DEAD = false;
boolean DRAW_PREDATOR = false;
boolean DRAW_POST_CHOMP_GROWTH = false;

boolean DRAW_ORGANISM = true;

class Paint
{
  Paint()
  {
  }

  void show(Organism organism)
  {
    if (!DRAW_ORGANISM)
    {
      return;
    }

    stroke(organism.colour, 140);
    fill(organism.colour, 100);

    //if (organism.species == Genome.Species.Snake)
    //{
    //  //stroke(0);
    //  ellipse(organism.displacement().x, organism.displacement().y, 
    //    0.5 * (sin(CLOCK + organism.timeOffset())* organism.mass) + organism.mass, organism.mass);
    //} else
    {
      //stroke(0);
      ellipse(organism.displacement().x, 
        organism.displacement().y, 
        organism.mass, 
        organism.mass);
    }
  }

  void show(Organism organism, color colour, boolean FLAG)
  {
    if (!FLAG)
    {
      return;
    }

    stroke(0);
    fill(colour);
    rect(organism.displacement().x - organism.mass / 2
      , organism.displacement().y - organism.mass / 2
      , organism.mass, organism.mass);
  }
}
