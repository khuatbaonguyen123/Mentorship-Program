import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ThreeCardGameHandler implements Shufflable, Dealable {

    private static final int INITIAL_NUMBER_OF_CARDS_PLAYER = 3;
    private Deck deck;
    private List<ThreeCardPlayer> players;

    public ThreeCardGameHandler() {
        deck = new Deck();
        players = new ArrayList<>();
    }

    public Deck getDeck() {
        return deck;
    }

    @Override
    public void shuffleCard(Deck deck) {
        List<Card> cards = deck.getCards();
        Collections.shuffle(cards);
    }

    public void addPlayer(ThreeCardPlayer threeCardPlayer) {
        players.add(threeCardPlayer);
    }

    public List<ThreeCardPlayer> getPlayers() {
        return players;
    }

    @Override
    public void dealCard() {
        List<Card> cards = deck.getCards();
        for (ThreeCardPlayer player : players) {
            for (int i = 0; i < INITIAL_NUMBER_OF_CARDS_PLAYER; i++) {
                if (!cards.isEmpty()) {
                    Card card = cards.remove(cards.size() - 1);
                    player.addCardToHand(card);
                }
            }
        }
    }

}
