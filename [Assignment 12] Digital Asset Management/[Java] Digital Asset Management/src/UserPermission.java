public class UserPermission {
    private User user;
    private Store store;
    private Permission permission;

    public UserPermission(User user, Store store, Permission permission) {
        this.user = user;
        this.store = store;
        this.permission = permission;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Store getStore() {
        return this.store;
    }

    public void setStore(Store store) {
        this.store = store;
    }
    
    public Permission getPermission() {
        return this.permission;
    }

    public void setPermission(Permission permission) {
        this.permission = permission;
    }

}
