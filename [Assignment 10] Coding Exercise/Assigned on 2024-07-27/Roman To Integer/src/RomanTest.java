import org.junit.Test;
import org.junit.Assert;

public class RomanTest {

    @Test
    public void toIntegerTest() {
        Roman roman = new Roman("CXXIII");

        Assert.assertEquals(123, roman.toInteger());
    }

    @Test
    public void isRomanNullTest() {
        Assert.assertFalse(Roman.isRoman(null));
    }

    @Test
    public void isRomanInvalidTest() {
        Assert.assertFalse(Roman.isRoman("chlsXM"));
    }

    @Test
    public void isRomanValidTest() {
        Assert.assertTrue(Roman.isRoman("XIII"));
    }
}
