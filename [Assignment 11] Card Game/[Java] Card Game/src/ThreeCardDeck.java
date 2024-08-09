import java.util.ArrayList;
import java.util.Arrays;

public class ThreeCardDeck implements IDeck {

    private static ArrayList<ICard> cards = new ArrayList<>();
    private static ArrayList<String> ranks = new ArrayList<>(Arrays.asList("2", "3", "4", "5", "6", "7", "8", "9", "A"));
    private static ArrayList<String> suits = new ArrayList<>(Arrays.asList("Hearts", "Diamonds", "Clubs", "Spades"));

    public ThreeCardDeck() {
        createCards();
    }

    public ArrayList<ICard> getCards() {
        return cards;
    }

    public static ArrayList<String> getRanks() {
        return ranks;
    }

    public static ArrayList<String> getSuits() {
        return suits;
    }

    private static void createCards() {
        for (String suit : suits) {
            for (String rank : ranks) {
                cards.add(new ThreeCardCard(suit, rank));
            }
        }
    }

}
