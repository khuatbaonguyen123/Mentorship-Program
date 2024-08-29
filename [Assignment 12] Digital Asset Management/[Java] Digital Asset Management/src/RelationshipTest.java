import org.junit.Assert;
import org.junit.Test;

public class RelationshipTest {
    
    @Test
    public void userOwnMultipleDrivesTest() {
        User Alex = new User("Alex");

        Drive oneDrive = new Drive("One Drive");
        Drive googleDrive = new Drive("Google Drive");

        Alex.addDrive(googleDrive);
        Alex.addDrive(oneDrive);

        Assert.assertEquals(2, Alex.getDrives().size());

        Assert.assertEquals(Alex, googleDrive.getOwner());
        Assert.assertEquals(Alex, oneDrive.getOwner());  
    }
}
