public class ThreeCardCard implements ICard {

    private String suit;
    private String rank;

    public ThreeCardCard(String suit, String rank) {
        this.suit = suit;
        this.rank = rank;
    }

    @Override
    public String getSuit() {
        return suit;
    }

    @Override
    public String getRank() {
        return rank;
    }

    @Override
    public String toString() {
        return rank + " of " + suit;
    }
    
}
