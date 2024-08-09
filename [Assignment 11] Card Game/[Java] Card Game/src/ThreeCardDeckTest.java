import org.junit.Test;

import java.util.ArrayList;
import java.util.Arrays;

import org.junit.Assert;

public class ThreeCardDeckTest {

    private static ThreeCardDeck threeCardDeck = new ThreeCardDeck();

    @Test
    public void deckSizeTest() {
        int deckSize = threeCardDeck.getCards().size();

        Assert.assertEquals(36, deckSize);
    }

    @Test
    public void validRanksTest() {
        ArrayList<String> expectedRanks = new ArrayList<>(Arrays.asList("2", "3", "4", "5", "6", "7", "8", "9", "A"));

        ArrayList<String> actualRanks = ThreeCardDeck.getRanks();

        Assert.assertTrue(expectedRanks.containsAll(actualRanks) && actualRanks.containsAll(expectedRanks));

    }

    @Test
    public void noDuplicateTest() {

    }

    @Test
    public void includeAllSuitsTest() {

    } 
}
