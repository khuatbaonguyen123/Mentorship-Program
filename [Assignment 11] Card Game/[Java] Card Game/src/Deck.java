import java.util.ArrayList;

public class Deck {

    private ArrayList<Card> cards;

    public Deck() {
        createCards();
    }

    public ArrayList<Card> getCards() {
        return cards;
    }

    private void createCards() {
        cards = new ArrayList<>();

        for (Suit suit : Suit.values()) {
            for (Rank rank : Rank.values()) {
                cards.add(new Card(suit, rank));
            }
        }
    }

    public int getSize() {
        return cards.size();
    }

}
