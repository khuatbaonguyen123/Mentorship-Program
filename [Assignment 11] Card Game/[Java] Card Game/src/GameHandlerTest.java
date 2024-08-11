import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

public class GameHandlerTest {

    @Test
    public void shuffleCardTest() {
        GameHandler gameHandler = new GameHandler();
        Deck deck = gameHandler.getDeck();

        List<Card> originalOrder = new ArrayList<>(deck.getCards());
        gameHandler.shuffleCard(deck);
        List<Card> shuffleOrder = deck.getCards();
        
        Assert.assertNotEquals(originalOrder, shuffleOrder);
    }

    @Test
    public void dealCardTest() {
        GameHandler gameHandler = new GameHandler();
        Deck deck = gameHandler.getDeck();

        gameHandler.addPlayer(new Player(1, "Lily"));
        gameHandler.addPlayer(new Player(2, "Katy"));
        gameHandler.addPlayer(new Player(3, "Shu"));

        List<Player> players = gameHandler.getPlayers();
        int numberOfPlayers = players.size();

        gameHandler.dealCard(5); // Deal 5 cards to each player

        for(Player player : players) {
            Assert.assertFalse(player.getHand().size() != 5);
        }

        int expectedNumCardsRemained = 52 - numberOfPlayers * 5;

        Assert.assertEquals(expectedNumCardsRemained, deck.getSize());
    }
    
}
