class Senses{
    ArrayList<PVector> m_perceptible = new ArrayList<PVector>();
    ArrayList<PVector> m_repulsions = new ArrayList<PVector>();
    PVector m_attraction;
    ArrayList<PVector> m_collisions = new ArrayList<PVector>();

    ArrayList<Species> prey = new ArrayList<Species>();
    ArrayList<Species> predators = new ArrayList<Species>();
    
    private Organism m_self;
    private float distance = 50;

    public Senses(Organism organism){
        m_self = organism; 
    }

    void checkCollision(Organism other){
        PVector selfToOtherVector = other.displacement().copy().sub(m_self.displacement()); 
        float distanceBetweenCenters = selfToOtherVector.mag();
        if (distanceBetweenCenters > (other.mass + m_self.mass)/2)
        {
        } else {

            painter.show(m_self, WHITE, DRAW_OVERLAP || DRAW_COLLISION);
            painter.show(other, WHITE, DRAW_OVERLAP || DRAW_COLLISION);
            m_collisions.add(other.displacement());
        }
    }

    void update(){

    }

    void isPerceptible(){
        
    }

    void isAttraction(Organism organism){

    }

    void isRepulsion(Organism organism){

    }


}

class SnakeSenses extends Senses{
    public SnakeSenses(Organism organism){
        super(organism);
        prey.add(Species.Fish);
        predators.add(Species.Fish);
    }

}
class FishSenses extends Senses{
    public FishSenses(Organism organism){
        super(organism);
        prey.add(Species.Algae);
        prey.add(Species.Snake);
        predators.add(Species.Snake);
    }
}
