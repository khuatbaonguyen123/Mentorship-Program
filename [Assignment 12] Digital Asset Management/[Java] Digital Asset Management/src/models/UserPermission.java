package models;

import roles.Role;

public class UserPermission {
    private User user;
    private Store store;
    private Role role;

    public UserPermission(User user, Store store, Role role) {
        this.user = user;
        this.store = store;
        this.role = role;
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
    
    public Role getRole() {
        return this.role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

}
