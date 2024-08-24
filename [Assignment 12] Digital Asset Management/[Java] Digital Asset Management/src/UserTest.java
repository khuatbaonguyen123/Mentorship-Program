import org.junit.Assert;
import org.junit.Test;
import org.junit.Before;

public class UserTest {

    private static User Jane, Sarah, John, Emily;
    private static Drive googleDrive;
    private static Drive oneDrive;

    @Before
    public void setUpUserDrive() {
        Jane = new User("Jane");
        Sarah = new User("Sarah");
        John = new User("John");
        Emily = new User("Emily");

        googleDrive = new Drive("Google Drive");
        oneDrive = new Drive("One Drive");
    }

    @Test
    public void userOwnMultipleDrivesTest() {
        Jane.addDrive(googleDrive);
        Jane.addDrive(oneDrive);

        Assert.assertEquals(2, Jane.getDrives().size());

        Assert.assertEquals(Jane, googleDrive.getOwner());
        Assert.assertEquals(Jane, oneDrive.getOwner());
    }

    @Test
    public void driveOwnerAddFolderToDriveTest() {
        Jane.addDrive(googleDrive);

        Folder folder = new Folder("Client Work");

        // In the addStore function, before add, I also call the hasPermission function
        // So should I test that function before this or I can leave that function to test after
        // and just follow the business flow?
        Assert.assertTrue(Jane.addStore(googleDrive, folder));

        // Jane is the person who added (created) the folder so she is the owner of the folder
        Assert.assertEquals(Jane, folder.getOwner());
        Assert.assertEquals(folder, googleDrive.getChildrenStores().get(0));
    }

    @Test
    public void folderOwnerAddSubFolderToFolderTest() {
        Jane.addDrive(googleDrive);

    }
}
