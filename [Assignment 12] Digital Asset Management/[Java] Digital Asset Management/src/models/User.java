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
    // public boolean addItem(Item item, Drive drive) {
    //     Permission drivePermission = drive.checkPermission(this);

    //     if (drivePermission == Permission.ADMIN || drivePermission == Permission.CONTRIBUTOR) {
    //         drive.addItem(item);
    //         item.setOwner(this);
    //         return true;
    //     } 

    //     return false;
    // }

    public void addItem(Item item, Drive drive) {
        Role thisUserRole = drive.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canAdd()) {
            drive.addItem(item);
            item.setOwner(this);
        } else {
            throw new IllegalStateException("User does not have the required permission to add items to drive.");
        }
    }

    public void deleteStore(Store store) {
        Role thisUserRole = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canDelete()) {
            store.delete();
        } else {
            throw new IllegalStateException("User does not have the required permission to delete items in drive.");
        }
    }

    public void grantPermission(User user, Store store, Role role) {
        Role thisUserRole = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(thisUserRole);

        if(roleBehavior.canGrantPermission()) {
            store.grantPermission(user, role);
        } else {
            throw new IllegalStateException("User does not have the required permission to grant access.");
        }
    }

    public void modifyName(Store store, String newName) {
        Role storePermission = store.checkPermission(this);
        RoleBehavior roleBehavior = RoleBehaviorMap.getRoleBehavior(storePermission);

        if(roleBehavior.canModify()) {
            store.setName(newName);
        } else {
            throw new IllegalStateException("User does not have the required permission to modify name.");
        }
    }
}
