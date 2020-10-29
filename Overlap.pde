boolean MOVE_OUT_OF_OVERLAP = true;

static class _Overlap {

  enum Type { 
    None, 
    Partial, 
    EnclosureOfSelf, 
    EnclosureOfOther, 
    MutualEnclosure
  }
}

class Overlap
{
  private Organism self;
  private Organism other;

  private float right1ToLeft2;   
  private float right2ToLeft1;
  private float bottom1ToTop2;
  private float bottom2ToTop1;

  _Overlap.Type type;

  Overlap(Organism _self, Organism _other)
  {
    self = _self;
    other = _other;
    init();
    if(MOVE_OUT_OF_OVERLAP)
    {
      moveOut();
    }
  }

  private void init()
  {
    float offset1 = sqrt(sq(self.mass/2) / 2);
    float offset2 = sqrt(sq(other.mass/2) / 2);

    float left1 = self.displacement().x - offset1;
    float right1 = self.displacement().x + offset1;
    float top1 = self.displacement().y - offset1;
    float bottom1 = self.displacement().y + offset1;

    float left2 = other.displacement().x - offset2;
    float right2 = other.displacement().x + offset2;
    float top2 = other.displacement().y - offset2;
    float bottom2 = other.displacement().y + offset2;

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
      type = _Overlap.Type.EnclosureOfSelf;
    } else if (left2 > left1 && right2 < right1 &&
      top2 > top1 && bottom2 < bottom1)
    {
      type = _Overlap.Type.EnclosureOfOther;
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
    
    float otherWeight = pow(self.mass, 3);
    float selfWeight = pow(other.mass, 3);

    float totalWeight = selfWeight + otherWeight;
    selfWeight /= totalWeight;
    otherWeight /= totalWeight;

    if (right2ToLeft1 > 0 && right2ToLeft1 <= right1ToLeft2)
    {

      self.displacement().add(right2ToLeft1 * selfWeight, 0);
      other.displacement().add(-right2ToLeft1 * otherWeight, 0);

    } else if (right1ToLeft2 > 0  && right1ToLeft2 <= right2ToLeft1)
    {

      self.displacement().add(-right1ToLeft2 * selfWeight, 0);
      other.displacement().add(right1ToLeft2 * otherWeight, 0);

    }  

    if (bottom1ToTop2 > 0 && bottom1ToTop2 <= bottom2ToTop1)
    {

      self.displacement().add(0, -bottom1ToTop2 * selfWeight);
      other.displacement().add(0, bottom1ToTop2 * otherWeight);

    } else if (bottom2ToTop1 > 0 && bottom2ToTop1 <= bottom1ToTop2)
    {

      self.displacement().add(0, bottom2ToTop1 * selfWeight);
      other.displacement().add(0, -bottom2ToTop1 * otherWeight);

    }
  }
}
