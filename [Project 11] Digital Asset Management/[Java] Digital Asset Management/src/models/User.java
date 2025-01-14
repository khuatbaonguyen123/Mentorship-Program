package models;
import java.util.ArrayList;
import java.util.List;

import interfaces.RoleBehavior;
import roles.Role;
import roles.RoleBehaviorMap;

public class User {
    private String name;

    private List<Drive> drives;

    public User(String name) {
        this.name = name;
        drives = new ArrayList<>();
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Drive> getDrives() {
        return drives;
    }

    public void addDrive(Drive drive) {
        drives.add(drive);
        drive.setOwner(this);
    }

    /*
     * This method is only to demo what it's like to use ||
     */
    // public boolean addStore(Store Store, Drive drive) {
    //     Permission drivePermission = drive.checkPermission(this);

    //     if (drivePermission == Permission.ADMIN || drivePermission == Permission.CONTRIBUTOR) {
    //         drive.addStore(Store);
    //         Store.setOwner(this);
    //         return true;
    //     } 

    //     return false;
    // }

    public void addStore(Store Store, Drive drive) {
        Role thisUserRole = drive.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canAdd() && !drive.isDeleted()) {
            drive.addStore(Store);
            Store.setOwner(this);
        } else {
            throw new IllegalStateException("User does not have the required permission to add Stores to drive.");
        }
    }

    public void addStore(Store Store, Folder folder) {
        Role thisUserRole = folder.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canAdd() && !folder.isDeleted()) {
            folder.addStore(Store);
            Store.setOwner(this);
        } else {
            throw new IllegalStateException("User does not have the required permission to add Stores to folder.");
        }
    }

    public void deleteStore(Store store) {
        Role thisUserRole = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canDelete() && !store.isDeleted()) {
            store.delete();
        } else {
            throw new IllegalStateException("User does not have the required permission to delete.");
        }
    }

    public void grantPermission(User user, Store store, Role role) {
        Role thisUserRole = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canGrantPermission() && !store.isDeleted()) {
            store.grantPermission(user, role);
        } else {
            throw new IllegalStateException("User does not have the required permission to grant access.");
        }
    }

    public void modifyName(Store store, String newName) {
        Role storePermission = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(storePermission);

        if(roleBehavior.canModify() && !store.isDeleted()) {
            store.setName(newName);
        } else {
            throw new IllegalStateException("User does not have the required permission to modify name.");
        }
    }

    public boolean canRead(Store store) {
        Role storePermission = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(storePermission);
    
        if(roleBehavior.canRead() && !store.isDeleted()) {
            return true; // Permission granted
        } else {
            throw new IllegalStateException("User does not have the required permission to view the contents.");
        }
    }
}
