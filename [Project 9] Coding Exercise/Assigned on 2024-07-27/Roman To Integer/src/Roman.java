import java.util.HashMap;
import java.util.Map;

public class Roman {
    private static final Map<Character, Integer> ROMAN_TO_INT_MAP = new HashMap<>();

    static {
        ROMAN_TO_INT_MAP.put('I', 1);
        ROMAN_TO_INT_MAP.put('V', 5);
        ROMAN_TO_INT_MAP.put('X', 10);
        ROMAN_TO_INT_MAP.put('L', 50);
        ROMAN_TO_INT_MAP.put('C', 100);
        ROMAN_TO_INT_MAP.put('D', 500);
        ROMAN_TO_INT_MAP.put('M', 1000);
    }

    private String romanString;

    public Roman(String romanString) {
        this.romanString = romanString;
    }

    public String getRomanString() {
        return romanString;
    }

    public void setRomanString(String romanString) {
        this.romanString = romanString;
    }

    public static boolean isRoman(String input) {
        String regex = "^(M{0,3})(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$";
        return input != null && input.matches(regex);
    }

    public int toInteger() {
        int result = 0;
        int prevValue = 0;

        for (int i = romanString.length() - 1; i >= 0; i--) {
            int value = ROMAN_TO_INT_MAP.get(romanString.charAt(i));

            if (value < prevValue) {
                result -= value;
            } else {
                result += value;
            }

            prevValue = value;
        }

        return result;
    }
}
