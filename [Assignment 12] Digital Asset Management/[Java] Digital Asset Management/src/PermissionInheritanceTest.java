import org.junit.Assert;
import org.junit.Test;

public class PermissionInheritanceTest {

    private static Drive googleDrive;
    private static Folder mentorship;
    private static Folder subFolder;

    private static void setUp() {
        User user = new User(1, "Nguyen");

        Drive drive = new Drive(1, "Google Drive");

        user.addDrive(drive);

        Folder mentorship = new Folder(1, "Mentorship");

        drive.addFolder(mentorship);

        Folder mentorship2024 = new Folder(2, "Mentorship 2024");

        User user2 = new User(2, "Katy");

        user.grantPermission(user2, drive, "ADMIN");

        Assert.assertTrue(user2.hasPermission(drive, "ADMIN"));
    }
    
    @Test
    public void FolderAndFileInheritPermissionFromParentDriveTest() {

    }

    @Test
    public void SubFolderAndFileInheritPermissionFromParentFolerTest() {

    }

    @Test
    public void FilesInSubFolderInheritPermissionFromFolderTest() {

    }

    @Test
    public void OverrideInheritedPermissionsTest() {

    }

    @Test
    public void ShareFolderWithoutDrivePermissionTest() {

    }

    @Test
    public void ShareSubFolderWithoutFolderPermissionTest() {

    }

    @Test
    public void ShareFileWithoutParentFolderTest() {

    }

    @Test
    public void ShareFileWithoutOtherFilesInFolderPermissionTest() {

    }

}
