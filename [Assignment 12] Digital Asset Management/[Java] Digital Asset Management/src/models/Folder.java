package models;

import java.util.ArrayList;
import java.util.List;

import roles.Role;

public class Folder extends Container {

    public Folder(String name) {
        super(name);
        childStores = new ArrayList<>();
    }

    public List<Store> getChildStores() {
        return this.childStores;
    }

    public void setChildStores(List<Store> childStores) {
        this.childStores = childStores;
    }

    @Override
    public void propagatePermission(User user, Role role) {
        for (Store Store : childStores) {
            Store.grantPermission(user, role);

            Store.propagatePermission(user, role);
        }
    }

    public void addStore(Store Store) {
        childStores.add(Store);
    }

    @Override
    public void delete() {
        this.markAsDeleted();
        
        for(Store Store : childStores) {
            Store.delete();
        }
    }

    public boolean contains(Store Store) {
        return childStores.contains(Store);
    }

}
