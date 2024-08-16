import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.Assert;

public class ThreeCardTest {

    private ThreeCardGameHandler gameHandler;
    private List<ThreeCardPlayer> players;

    @Before
    public void setUp() {
        gameHandler = new ThreeCardGameHandler();
        players = gameHandler.getPlayers();

        // Add common players setup
        ThreeCardPlayer player1 = new ThreeCardPlayer(1, "Lily");
        ThreeCardPlayer player2 = new ThreeCardPlayer(2, "Katy");
        ThreeCardPlayer player3 = new ThreeCardPlayer(3, "Shu");

        gameHandler.addPlayer(player1);
        gameHandler.addPlayer(player2);
        gameHandler.addPlayer(player3);
    }

    @Test
    public void shuffleCardTest() {
        Deck deck = gameHandler.getDeck();

        List<Card> originalOrder = new ArrayList<>(deck.getCards());
        gameHandler.shuffleCard(deck);
        List<Card> shuffleOrder = deck.getCards();

        Assert.assertNotEquals(originalOrder, shuffleOrder);
    }

    @Test
    public void dealCard_ThreeCardsPerPlayerTest() {
        Deck deck = gameHandler.getDeck();

        gameHandler.shuffleCard(deck);
        gameHandler.dealCard();

        // Verify if each player has 3 cards after calling the function
        for (ThreeCardPlayer player : players) {
            Assert.assertEquals(3, player.getHand().size());
        }
    }

    @Test
    public void dealCard_NoInvalidRankTest() {
        gameHandler.dealCard();

        for (ThreeCardPlayer player : players) {
            for (Card card : player.getHand()) {
                Assert.assertNotEquals("Card should not be 10", Rank.TEN, card.getRank());
                Assert.assertNotEquals("Card should not be J", Rank.JACK, card.getRank());
                Assert.assertNotEquals("Card should not be Q", Rank.QUEEN, card.getRank());
                Assert.assertNotEquals("Card should not be K", Rank.KING, card.getRank());
            }
        }
    }

    @Test
    public void defineWinnersTest() {
        players.get(0).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.THREE),
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.THREE)
        ));

        players.get(1).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.ACE),
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.TWO)
        ));

        players.get(2).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.NINE),
            new Card(Suit.CLUBS, Rank.SEVEN),
            new Card(Suit.DIAMONDS, Rank.EIGHT)
        ));

        List<Player> winners = gameHandler.defineWinners();

        Assert.assertEquals("There should be 2 winners", 2, winners.size());
        Assert.assertTrue("Player 1 is a winner", winners.contains(players.get(0)));
        Assert.assertTrue("Player 3 is a winner", winners.contains(players.get(2)));
    }

    @Test
    public void calculateHandTest() {
        players.get(0).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.THREE),
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.THREE)
        ));

        int actualValue = gameHandler.calculateHand(players.get(0));

        Assert.assertEquals("Actual value has to be 4", 4, actualValue);
    }

    @Test
    public void findMaxHandValueTest() {
        players.get(0).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.THREE),
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.THREE)
        ));

        players.get(1).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.ACE),
            new Card(Suit.CLUBS, Rank.EIGHT),
            new Card(Suit.DIAMONDS, Rank.TWO)
        ));

        players.get(2).addCardToHand(Arrays.asList(
            new Card(Suit.HEARTS, Rank.NINE),
            new Card(Suit.CLUBS, Rank.SEVEN),
            new Card(Suit.DIAMONDS, Rank.NINE)
        ));

        int actualMaxHandValue = gameHandler.findMaxHandValue();

        Assert.assertEquals(5, actualMaxHandValue);
    }
}
