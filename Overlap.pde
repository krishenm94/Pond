static class _Overlap {

  enum Type { 
    None, 
    Partial, 
    EnclosureOfOne, 
    EnclosureOfTwo, 
    MutualEnclosure
  }
}

class Overlap
{
  private Organism organism1;
  private Organism organism2;

  private float right1ToLeft2;   
  private float right2ToLeft1;
  private float bottom1ToTop2;
  private float bottom2ToTop1;

  _Overlap.Type type;

  Overlap(Organism _organism1, Organism _organism2)
  {
    organism1 = _organism1;
    organism2 = _organism2;
    init();
  }

  private void init()
  {
    float left1 = organism1.displacement().x - organism1.mass/2;
    float right1 = organism1.displacement().x + organism1.mass/2;
    float top1 = organism1.displacement().y - organism1.mass/2;
    float bottom1 = organism1.displacement().y + organism1.mass/2;

    float left2 = organism2.displacement().x - organism2.mass/2;
    float right2 = organism2.displacement().x + organism2.mass/2;
    float top2 = organism2.displacement().y - organism2.mass/2;
    float bottom2 = organism2.displacement().y + organism2.mass/2;

    right2ToLeft1 = right2 - left1;
    right1ToLeft2 = right1 - left2;
    bottom1ToTop2 = bottom1 - top2;
    bottom2ToTop1 = bottom2  - top1;

    if (left1 > right2 || left2 > right1 ||
      top1 > bottom2 || top2 > bottom1)
    {
      type = _Overlap.Type.None;
    } else if (left1 == left2 && right1 == right2 &&
      top1 == top2 && bottom1 == bottom2)
    {
      type = _Overlap.Type.MutualEnclosure;
    } else if (left1 > left2 && right1 < right2 &&
      top1 > top2 && bottom1 < bottom2)
    {
      type = _Overlap.Type.EnclosureOfOne;
    } else if (left2 > left1 && right2 < right1 &&
      top2 > top1 && bottom2 < bottom1)
    {
      type = _Overlap.Type.EnclosureOfTwo;
    } else
    { 
      type = _Overlap.Type.Partial;
    }
  }

  void moveOut()
  {
    if(type == _Overlap.Type.None)
    {
      return;
    }
    
    int offset = 0;

    float weight2 = pow(organism1.mass, 3);
    float weight1 = pow(organism2.mass, 3);

    float totalWeight = weight1 + weight2;
    weight1 /= totalWeight;
    weight2 /= totalWeight;

    if (right2ToLeft1 > 0 && right2ToLeft1 <= right1ToLeft2)
    {
      float overlap = right2ToLeft1 + offset;

      organism1.displacement().add(overlap * weight1, 0);
      organism2.displacement().add(-overlap * weight2, 0);
    } else if (right1ToLeft2 > 0  && right1ToLeft2 <= right2ToLeft1)
    {
      float overlap = right1ToLeft2 + offset;

      organism1.displacement().add(-overlap * weight1, 0);
      organism2.displacement().add(overlap* weight2, 0);
    }  

    if (bottom1ToTop2 > 0 && bottom1ToTop2 <= bottom2ToTop1)
    {
      float overlap = bottom1ToTop2 + offset;

      organism1.displacement().add(0, -overlap * weight1);
      organism2.displacement().add(0, overlap* weight2);
    } else if (bottom2ToTop1 > 0 && bottom2ToTop1 <= bottom1ToTop2)
    {
      float overlap = bottom2ToTop1 + offset;

      organism1.displacement().add(0, overlap * weight1);
      organism2.displacement().add(0, -overlap* weight2);
    }
  }
}
