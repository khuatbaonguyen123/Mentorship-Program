import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

public class ThreeCardTest {

    @Test
    public void shuffleCardTest() {
        ThreeCardGameHandler gameHandler = new ThreeCardGameHandler();
        Deck deck = gameHandler.getDeck();

        List<Card> originalOrder = new ArrayList<>(deck.getCards());
        gameHandler.shuffleCard(deck);
        List<Card> shuffleOrder = deck.getCards();
        
        Assert.assertNotEquals(originalOrder, shuffleOrder);
    }

    @Test
    public void dealCardTest() {
        ThreeCardGameHandler gameHandler = new ThreeCardGameHandler();
        Deck deck = gameHandler.getDeck();

        gameHandler.addPlayer(new ThreeCardPlayer(1, "Lily"));
        gameHandler.addPlayer(new ThreeCardPlayer(2, "Katy"));
        gameHandler.addPlayer(new ThreeCardPlayer(3, "Shu"));

        List<ThreeCardPlayer> players = gameHandler.getPlayers();
        int numberOfPlayers = players.size();

        gameHandler.dealCard(); // Verify if each player has 3 cards after call the function

        for(ThreeCardPlayer player : players) {
            Assert.assertFalse(player.getHand().size() != 3);
        }

        int expectedNumCardsRemained = 52 - numberOfPlayers * 3;

        Assert.assertEquals(expectedNumCardsRemained, deck.getSize());
    }
}
