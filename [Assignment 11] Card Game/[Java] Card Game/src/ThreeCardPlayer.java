import java.util.ArrayList;
import java.util.List;

public class ThreeCardPlayer implements IHandPlayer{

    private int id;
    private String name;
    private List<Card> hand;

    public ThreeCardPlayer(int id, String name) {
        this.id = id;
        this.name = name;
        this.hand = new ArrayList<>();        
    }

    public int getID() {
        return id;
    }

    public void setID(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public List<Card> getHand() {
        return hand;
    }

    @Override
    public void addCardToHand(Card card) {
        hand.add(card);
    }

}
