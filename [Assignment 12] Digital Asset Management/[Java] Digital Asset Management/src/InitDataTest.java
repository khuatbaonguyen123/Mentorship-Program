import org.junit.Assert;
import org.junit.Test;

public class InitDataTest {
    
    @Test
    public void initUserDataTest() {
        User user = new User("Nguyen");

        Assert.assertNotNull(user.getDrives());
        Assert.assertNotNull(user.getStores());
    }

    @Test
    public void initDriveDataTest() {
        Drive drive = new Drive("Google Drive");

        Assert.assertNotNull(drive.getChildrenStores());
        Assert.assertNotNull(drive.getPermissions());
    }
}
