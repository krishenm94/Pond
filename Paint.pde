boolean DRAW_BIRTH = false;
boolean DRAW_DADDY = false;
boolean DRAW_BABY = false;

boolean DRAW_DEAD = false;
boolean DRAW_PREDATOR = false;

boolean DRAW_ORGANISM = true;

class Paint
{
  Paint()
  {
  }
  
  void birth(Organism organism)
  {   
    if (!DRAW_BIRTH)
    {
      return;
    }
    stroke(0, 255, 255);
    fill(0, 255, 255);
    rect(this.displacement().x, this.displacement().y, this.mass(), this.mass());
  }

  void daddy(Organism organism)
  {
    if (!DRAW_DADDY)
    {

      return;
    }
    stroke(0, 255, 0);
    fill(0, 70, 180);
    rect(this.displacement().x, this.displacement().y, this.mass(), this.mass());
  }

  void baby(Organism organism)
  {
    if (!DRAW_BABY)
    {
      return;
    }
    stroke(0, 0, 100);
    fill(0, 150, 25);
    rect(organism.displacement().x, organism.displacement().y, organism.mass(), organism.mass());
  }

  void show(Organism organism)
  {
    if (!DRAW_ORGANISM)
    {
      return;
    }

    stroke(organism.colour, 40);
    fill(organism.colour, 20);
    ellipse(organism.displacement().x, organism.displacement().y, organism.mass(), organism.mass());
  }

  void dead(Organism organism)
  {

    if (!DRAW_DEAD)
    {
      return;
    }

    stroke(255);
    fill(0);
    rect(organism.displacement().x, organism.displacement().y, organism.mass(), organism.mass());
  }

  void predator(Organism organism)
  {
    if (!DRAW_PREDATOR)
    {
      return;
    }

    stroke(0);
    fill(255, 0, 0);
    rect(organism.displacement().x, organism.displacement().y, organism.mass(), organism.mass());
  }
}
