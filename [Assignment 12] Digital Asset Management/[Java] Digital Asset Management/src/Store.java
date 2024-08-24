import java.util.ArrayList;
import java.util.List;

public abstract class Store {
    protected String storeName;
    protected Long size;

    protected User owner;
    protected Store parentStore;
    protected Drive parentDrive;

    protected List<StoreUserPermission> permissions;

    public Store(String storeName) {
        this.storeName = storeName;
        permissions = new ArrayList<>();
    }

    public String getStoreName() {
        return this.storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public Long getSize() {
        return this.size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public User getOwner() {
        return this.owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Drive getParentDrive() {
        return this.parentDrive;
    }

    public void setParentDrive(Drive parentDrive) {
        this.parentDrive = parentDrive;
    }

    public Store getParentStore() {
        return this.parentStore;
    }

    public List<StoreUserPermission> getPermissions() {
        return this.permissions;
    }


}
