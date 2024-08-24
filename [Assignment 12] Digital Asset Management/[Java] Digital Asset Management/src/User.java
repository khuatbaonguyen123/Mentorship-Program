import java.util.ArrayList;
import java.util.List;

public class User {
    private String name;

    private List<Drive> drives;

    private List<Store> stores;

    public User(String name) {
        this.name = name;
        drives = new ArrayList<>();
        stores = new ArrayList<>();
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Drive> getDrives() {
        return this.drives;
    }

    public void setDrives(List<Drive> drives) {
        this.drives = drives;
    }

    public List<Store> getStores() {
        return this.stores;
    }

    public void setStores(List<Store> stores) {
        this.stores = stores;
    }

    public void addDrive(Drive drive) {
        drives.add(drive);
        drive.setOwner(this);
    }

    public boolean addStore(Drive drive, Store store) {
        if(this.hasAdminPermission(drive) || this.hasContributorPermission(drive)) {
            drive.addChild(store);
            store.setOwner(this);

            return true;
        }

        return false;
    }

    private boolean hasContributorPermission(Drive drive) {
        Permission permission = drive.checkPermission(this);

        return permission == Permission.CONTRIBUTOR;
    }

    private boolean hasAdminPermission(Drive drive) {
        Permission permission = drive.checkPermission(this);

        return permission == Permission.ADMIN;
    }
}
