public abstract class Item extends Store {
    protected Store parentStore;

    public Item(String name) {
        super(name);
    }

    public Store getParentStore() {
        return this.parentStore;
    }

    public void setParentStore(Store parentStore) {
        this.parentStore = parentStore;
    }
}
