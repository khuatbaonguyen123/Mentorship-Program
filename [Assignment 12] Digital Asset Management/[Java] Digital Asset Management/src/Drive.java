import java.util.ArrayList;
import java.util.List;

public class Drive extends Store {

    private List<Item> childItems;

    public Drive (String name) {
        super(name);
        childItems = new ArrayList<>();
    }

    public List<Item> getChildItems() {
        return this.childItems;
    }

    public void setChildItems(List<Item> childItems) {
        this.childItems = childItems;
    }

    public void addItem(Item item) {
        childItems.add(item);
    }

    @Override
    public void propagatePermission(User user, Permission permission) {
        for (Item item : childItems) {
            item.addPermission(user, permission);
            item.propagatePermission(user, permission);
        }
    }
    
}
