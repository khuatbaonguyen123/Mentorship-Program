import java.util.Scanner;

public class Main {

    private static String taskDetail = "Convert Roman to Integer (From 1 to 3999)";

    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws Exception {
        System.out.println(taskDetail);

        Roman roman = readRoman();
        int result = roman.toInteger();

        System.out.println("The integer value is: " + result);

        scanner.close();
    }

    public static Roman readRoman() {
        System.out.print("Enter a Roman numeral: ");
        String input = scanner.nextLine();

        while(!Roman.isRoman(input)) {
            System.out.print("Invalid input. Please enter again: ");
            input = scanner.nextLine();
        }

        return new Roman(input);
    }
}
