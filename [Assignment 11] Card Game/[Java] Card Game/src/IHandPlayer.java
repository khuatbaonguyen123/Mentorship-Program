import java.util.List;

public interface IHandPlayer {
    List<Card> getHand();
    void addCardToHand(Card card);
}
