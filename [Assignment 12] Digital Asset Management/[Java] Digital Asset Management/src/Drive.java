import java.util.ArrayList;
import java.util.List;

public class Drive {
    private String driveName;
    private User owner;
    private List<Store> childrenStores;

    private List<DriveUserPermission> permissions;

    public Drive(String driveName) {
        this.driveName = driveName;
        childrenStores = new ArrayList<>();
        permissions = new ArrayList<>();
    }

    public String getDriveName() {
        return this.driveName;
    }

    public void setDriveName(String driveName) {
        this.driveName = driveName;
    }

    public User getOwner() {
        return this.owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
        permissions.add(new DriveUserPermission(owner, Permission.ADMIN, this));
    }

    public List<Store> getChildrenStores() {
        return this.childrenStores;
    }

    public List<DriveUserPermission> getPermissions() {
        return this.permissions;
    }

    public void setPermissions(List<DriveUserPermission> permissions) {
        this.permissions = permissions;
    }

    public void addPermission(DriveUserPermission permission) {
        permissions.add(permission);
    }

    public void addChild(Store store) {
        childrenStores.add(store);
    }

    public Permission checkPermission(User user) {
        for (DriveUserPermission driveUserPermission : permissions) {
            if (driveUserPermission.getUser() == user) {
                return driveUserPermission.getPermission();
            }
        }

        return null;
    }

}
