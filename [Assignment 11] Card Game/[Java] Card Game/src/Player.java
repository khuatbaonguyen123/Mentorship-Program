import java.util.ArrayList;
import java.util.List;

public class Player {

    private int id;
    private String name;
    private List<Card> hand;

    public Player(int id, String name) {
        this.id = id;
        this.name = name;
        hand = new ArrayList<>();
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

    public List<Card> getHand() {
        return hand;
    }

    public void setHandEmpty() {
        hand.clear();
    }

    public void addCardToHand(Card card) {
        hand.add(card);
    }

}
