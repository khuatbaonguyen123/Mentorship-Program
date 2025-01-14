package models;

import java.util.ArrayList;
import java.util.List;

public abstract class Container extends Store {

    protected List<Store> childStores;

    public Container(String name) {
        super(name);
        childStores = new ArrayList<>();
    }

    public List<Store> getChildStores() {
        return childStores;
    }

    public void addChildStore(Store store) {
        childStores.add(store);
    }
    
}
