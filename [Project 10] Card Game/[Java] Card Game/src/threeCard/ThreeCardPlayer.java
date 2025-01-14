import java.util.ArrayList;
import java.util.List;

public class ThreeCardPlayer extends Player implements IHandPlayer {

    private List<Card> hand;

    public ThreeCardPlayer(int id, String name) {
        super(id, name);
        this.hand = new ArrayList<>();
    }

    @Override
    public List<Card> getHand() {
        return hand;
    }

    @Override
    public void addCardToHand(Card card) {
        hand.add(card);
    }

    @Override
    public void addCardToHand(List<Card> cards) {
        hand.addAll(cards);
    }

    @Override
    public boolean isHandEmpty() {
        return hand.isEmpty();
    }

}
