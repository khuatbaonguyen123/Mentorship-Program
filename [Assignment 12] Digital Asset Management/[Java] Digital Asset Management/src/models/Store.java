package models;

import java.util.ArrayList;
import java.util.List;

import roles.Role;

public abstract class Store {
    protected String name;
    protected User owner;

    protected List<UserPermission> permissions;
    protected boolean isDeleted = false;

    public Store(String name) {
        this.name = name;
        permissions = new ArrayList<>();
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getOwner() {
        return this.owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
        permissions.add(new UserPermission(owner, this, Role.ADMIN));
    }

    public void markAsDeleted() {
        this.isDeleted = true;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public List<UserPermission> getPermissions() {
        return this.permissions;
    }

    public void setPermissions(List<UserPermission> permissions) {
        this.permissions = permissions;
    }

    public void grantPermission(User user, Role role) {
        permissions.removeIf(up -> up.getUser().equals(user));
        permissions.add(new UserPermission(user, this, role));

        propagatePermission(user, role);
    }

    public Role checkPermission(User user) {
        for (UserPermission permission : permissions) {
            if (permission.getUser() == user) {
                return permission.getRole();
            }
        }

        return null;
    }

    public abstract void propagatePermission(User user, Role role);

    public abstract void delete();
}
