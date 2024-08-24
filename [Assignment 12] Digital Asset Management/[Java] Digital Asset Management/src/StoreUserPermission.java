public class StoreUserPermission extends UserPermission {
    private Store store;

    public StoreUserPermission(User user, Store store, Permission permission) {
        super(user, permission);
        this.store = store;
    }

    public Store getStore() {
        return this.store;
    }

    public void setStore(Store store) {
        this.store = store;
    }

}
