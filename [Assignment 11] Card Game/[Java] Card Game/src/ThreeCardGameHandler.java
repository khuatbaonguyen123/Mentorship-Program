import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class ThreeCardGameHandler implements Shufflable, Dealable, MultipleWinner {

    private static final int CARDS_PER_PLAYER = 3;
    private static final List<Rank> EXCLUDED_RANKS = Arrays.asList(Rank.TEN, Rank.JACK, Rank.QUEEN, Rank.KING);

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

        // Filter out cards based on the excluded ranks
        cards.removeIf(card -> EXCLUDED_RANKS.contains(card.getRank()));

        shuffleCard(deck);

        for (ThreeCardPlayer player : players) {
            for (int i = 0; i < CARDS_PER_PLAYER; i++) {
                if (!cards.isEmpty()) {
                    Card card = cards.remove(cards.size() - 1);
                    player.addCardToHand(card);
                }
            }
        }
    }

    @Override
    public List<Player> defineWinners() {
        int maxHandValue = findMaxHandValue();

        List<Player> winners = new ArrayList<>();

        for (ThreeCardPlayer player : players) {
            if (calculateHand(player) == maxHandValue) {
                winners.add(player);
            }
        }

        return winners;
    }

    public int findMaxHandValue() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findMaxHandValue'");
    }

    public int calculateHand(Player player) {
        
    }

}
