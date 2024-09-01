package models;

import java.util.ArrayList;
import java.util.List;

import roles.Role;

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
        item.setParentStore(this);
    }

    @Override
    public void propagatePermission(User user, Role role) {
        for (Item item : childItems) {
            item.grantPermission(user, role);
            item.propagatePermission(user, role);
        }
    }

    public void deleteItem(Item item) {
        if(childItems.contains(item)) {
            childItems.remove(item);
        } 
    }

    @Override
    public void delete() {
        this.markAsDeleted();
        
        for(Item item : childItems) {
            item.delete();
        }
    }

    public boolean contains(Item item) {
        return childItems.contains(item);
    }
}
