import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

public class ThreeCardTest {

    private ThreeCardGameHandler gameHandler;

    @Test
    public void shuffleCardTest() {
        gameHandler = new ThreeCardGameHandler();
        Deck deck = gameHandler.getDeck();

        List<Card> originalOrder = new ArrayList<>(deck.getCards());
        gameHandler.shuffleCard(deck);
        List<Card> shuffleOrder = deck.getCards();

        Assert.assertNotEquals(originalOrder, shuffleOrder);
    }

    @Test
    public void dealCard_ThreeCardsPerPlayerTest() {
        gameHandler = new ThreeCardGameHandler();
        Deck deck = gameHandler.getDeck();

        gameHandler.addPlayer(new ThreeCardPlayer(1, "Lily"));
        gameHandler.addPlayer(new ThreeCardPlayer(2, "Katy"));
        gameHandler.addPlayer(new ThreeCardPlayer(3, "Shu"));

        List<ThreeCardPlayer> players = gameHandler.getPlayers();

        gameHandler.shuffleCard(deck);
        gameHandler.dealCard();

        // Verify if each player has 3 cards after call the function
        for (ThreeCardPlayer player : players) {
            Assert.assertEquals(3, player.getHand().size());
        }
    }

    @Test
    public void dealCard_NoInvalidRankTest() {
        gameHandler = new ThreeCardGameHandler();

        gameHandler.addPlayer(new ThreeCardPlayer(1, "Lily"));
        gameHandler.addPlayer(new ThreeCardPlayer(2, "Katy"));
        gameHandler.addPlayer(new ThreeCardPlayer(3, "Shu"));

        List<ThreeCardPlayer> players = gameHandler.getPlayers();

        gameHandler.dealCard();

        for (ThreeCardPlayer player : players) {
            for (Card card : player.getHand()) {
                // Check that none of the cards are 10, J, Q, or K
                Assert.assertNotEquals("Card should not be 10", Rank.TEN, card.getRank());
                Assert.assertNotEquals("Card should not be J", Rank.JACK, card.getRank());
                Assert.assertNotEquals("Card should not be Q", Rank.QUEEN, card.getRank());
                Assert.assertNotEquals("Card should not be K", Rank.KING, card.getRank());
            }
        }
    }

    @Test
    public void defineWinnersTest() {
        gameHandler = new ThreeCardGameHandler();

        // 14 -> 4 points
        ThreeCardPlayer player1 = new ThreeCardPlayer(1, "Lily");
        player1.addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.THREE),
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.THREE)
        ));

        // 11 -> 1 points
        ThreeCardPlayer player2 = new ThreeCardPlayer(2, "Katy");
        player2.addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.ACE), // Ace = 1 point
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.TWO)
        ));

        // 24 -> 4 points
        ThreeCardPlayer player3 = new ThreeCardPlayer(3, "Shu");
        player3.addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.NINE),
            new Card(Suit.CLUBS, Rank.SEVEN),
            new Card(Suit.DIAMONDS, Rank.EIGHT)
        ));

        gameHandler.addPlayer(player1);
        gameHandler.addPlayer(player2);
        gameHandler.addPlayer(player3);

        List<Player> winners = gameHandler.defineWinners();

        // Multiple winners expected (player 1 and player 3)
        Assert.assertEquals("There should be 2 winners", 2, winners.size());

        Assert.assertTrue("Player 1 is winner", winners.contains(player1));
        Assert.assertTrue("Player 3 is winner", winners.contains(player3));
    }
    
}
