import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class GameHandler {

    private Deck deck;
    private ArrayList<Player> players;

    public GameHandler() {
        this.deck = new Deck();
        this.players = new ArrayList<>();
    }

    public Deck getDeck() {
        return deck;
    }

    public ArrayList<Player> getPlayers() {
        return players;
    }

    public void addPlayer(Player player) {
        player.setHandEmpty();
        players.add(player);
    }

    public void shuffleCard(Deck deck) {
        List<Card> cards = deck.getCards();
        Collections.shuffle(cards);
    }

    public void dealCard(int numberOfCards) {
        List<Card> cards = deck.getCards();
        for (Player player : players) {
            for (int i = 0; i < numberOfCards; i++) {
                if (!cards.isEmpty()) {
                    Card card = cards.remove(cards.size() - 1);
                    player.addCardToHand(card);
                }
            }
        }
    }

}
