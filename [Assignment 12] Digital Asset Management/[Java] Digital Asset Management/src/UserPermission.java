public abstract class UserPermission {
    protected User user;
    protected Permission permission;

    public UserPermission(User user, Permission permission) {
        this.user = user;
        this.permission = permission;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Permission getPermission() {
        return this.permission;
    }

    public void setPermission(Permission permission) {
        this.permission = permission;
    }

}
