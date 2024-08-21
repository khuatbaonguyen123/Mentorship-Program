import org.junit.Test;
import org.junit.Assert;

public class InitDataTest {

    @Test
    public void InitUserTest() {
        User user = new User(4, "Katy");

        Assert.assertEquals("Katy", user.getName());
    }

    @Test
    public void InitDriveTest() {
        Drive drive = new Drive(1, "Google Drive");

        Assert.assertEquals("Google Drive", drive.getName());
    }

    @Test
    public void InitFolderTest() {
        Folder folder = new Folder(1, "Mentorship");

        Assert.assertEquals("Mentorship", folder.getName());
    }

    @Test
    public void InitFileTest() {
        File file = new File(8, "year1.pdf");

        Assert.assertEquals("year1.pdf", file.getName());
    }
}
