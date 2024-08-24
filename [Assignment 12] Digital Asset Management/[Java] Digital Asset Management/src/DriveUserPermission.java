public class DriveUserPermission extends UserPermission {
    private Drive drive;

    public DriveUserPermission (User user, Permission permission, Drive drive) {
        super(user, permission);
        this.drive = drive;
    }

    public Drive getDrive() {
        return this.drive;
    }

    public void setDrive(Drive drive) {
        this.drive = drive;
    }
}
