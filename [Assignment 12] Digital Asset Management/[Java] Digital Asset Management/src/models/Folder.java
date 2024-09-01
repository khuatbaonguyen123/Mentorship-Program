package models;

import java.util.ArrayList;
import java.util.List;

import roles.Role;

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
    public void propagatePermission(User user, Role role) {
        for (Item item : childItems) {
            item.grantPermission(user, role);

            item.propagatePermission(user, role);
        }
    }

    public void addItem(Item item) {
        childItems.add(item);
        item.setParentStore(this);
    }

    @Override
    public void delete() {
        this.markAsDeleted();
        
        for(Item item : childItems) {
            item.delete();
        }
    }

}
