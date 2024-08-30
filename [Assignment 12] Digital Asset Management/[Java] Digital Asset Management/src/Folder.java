import java.util.ArrayList;
import java.util.List;

public class Folder extends Item {
    private List<Item> childItems;

    public Folder(String name) {
        super(name);
        childItems = new ArrayList<>();
    }

    public List<Item> getChildItems() {
        return this.childItems;
    }

    public void setChildItems(List<Item> childItems) {
        this.childItems = childItems;
    }

    @Override
    public void propagatePermission(User user, Permission permission) {
        for (Item item : childItems) {
            item.grantPermission(user, permission);

            item.propagatePermission(user, permission);
        }
    }

    public void addItem(Item item) {
        childItems.add(item);
    }

}
