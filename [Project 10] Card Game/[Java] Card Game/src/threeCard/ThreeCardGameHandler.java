import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.EnumMap;
import java.util.List;
import java.util.Map;

public class ThreeCardGameHandler implements Shufflable, Dealable, MultipleWinner {

    private static final int CARDS_PER_PLAYER = 3;
    private static final List<Rank> EXCLUDED_RANKS = Arrays.asList(Rank.TEN, Rank.JACK, Rank.QUEEN, Rank.KING);
    private static final Map<Rank, Integer> rankValues = new EnumMap<>(Rank.class);

    private Deck deck;
    private List<ThreeCardPlayer> players;

    public ThreeCardGameHandler() {
        deck = new Deck();
        players = new ArrayList<>();
        setRankValues();
    }

    public Deck getDeck() {
        return deck;
    }

    public void setDeck(Deck deck) {
        this.deck = deck;
    }

    public List<ThreeCardPlayer> getPlayers() {
        return players;
    }

    private static void setRankValues() {
        rankValues.put(Rank.ACE, 1);
        rankValues.put(Rank.TWO, 2);
        rankValues.put(Rank.THREE, 3);
        rankValues.put(Rank.FOUR, 4);
        rankValues.put(Rank.FIVE, 5);
        rankValues.put(Rank.SIX, 6);
        rankValues.put(Rank.SEVEN, 7);
        rankValues.put(Rank.EIGHT, 8);
        rankValues.put(Rank.NINE, 9);
    }

    @Override
    public void shuffleCard(Deck deck) {
        List<Card> cards = deck.getCards();
        Collections.shuffle(cards);
    }

    public void addPlayer(ThreeCardPlayer threeCardPlayer) {
        players.add(threeCardPlayer);
    }

    public void setHandEmpty(ThreeCardPlayer player) {
        if(!player.isHandEmpty()) {
            player.getHand().clear();
        }
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
        int maxHandValue = 0; // Start with the lowest possible value

        for (ThreeCardPlayer player : players) {
            int handValue = calculateHand(player);
            if (handValue > maxHandValue) {
                maxHandValue = handValue;
            }
        }

        return maxHandValue;
    }

    public int calculateHand(ThreeCardPlayer player) {
        int totalValue = 0;
        List<Card> hand = player.getHand();

        for (Card card : hand) {
            totalValue += rankValues.get(card.getRank());
        }

        return totalValue % 10;
    }

}
