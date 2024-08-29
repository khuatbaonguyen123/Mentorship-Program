import java.util.ArrayList;
import java.util.List;

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

    public boolean addItem(Item item, Drive drive) {
        Permission drivePermission = drive.checkPermission(this);

        if (drivePermission == Permission.ADMIN || drivePermission == Permission.CONTRIBUTOR) {
            drive.addItem(item);
            item.setOwner(this);
            return true;
        } 

        return false;
    }
}
