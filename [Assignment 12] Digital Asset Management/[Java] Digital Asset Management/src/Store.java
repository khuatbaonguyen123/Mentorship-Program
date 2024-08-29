import java.util.ArrayList;
import java.util.List;

public abstract class Store {
    protected String name;
    protected User owner;

    protected List<UserPermission> permissions;

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
        permissions.add(new UserPermission(owner, this, Permission.ADMIN));
    }

    public List<UserPermission> getPermissions() {
        return this.permissions;
    }

    public void setPermissions(List<UserPermission> permissions) {
        this.permissions = permissions;
    }

    public void addPermission(User user, Permission permission) {
        permissions.add(new UserPermission(user, this, permission));
        propagatePermission(user, permission);
    }

    public Permission checkPermission(User user) {
        for (UserPermission permission : permissions) {
            if (permission.getUser() == user) {
                return permission.getPermission();
            }
        }

        return null;
    }

    public abstract void propagatePermission(User user, Permission permission);
}
