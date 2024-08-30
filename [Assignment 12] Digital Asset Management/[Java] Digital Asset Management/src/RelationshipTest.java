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

    @Test
    public void driveHasMultipleItemsTest() {
        User Alex = new User("Alex");

        Drive googleDrive = new Drive("Google Drive");

        Folder designDocument = new Folder("Design Documents");
        Folder developmentFiles = new Folder("Development Files");
        File marketingMaterials = new File("Marketing Materials.pdf");

        Alex.addDrive(googleDrive);

        googleDrive.addItem(designDocument);
        googleDrive.addItem(developmentFiles);
        googleDrive.addItem(marketingMaterials);
        
        Assert.assertEquals(3, googleDrive.getChildItems().size());
    }

    @Test
    public void folderHasMultipleItemsTest() {
        User Alex = new User("Alex");
        Drive googleDrive = new Drive("Google Drive");

        Folder designDocument = new Folder("Design Documents");

        Folder wireframes = new Folder("Wireframes");
        Folder prototypes = new Folder("Prototypes");
        File mockup = new File("Mockup.png");

        Alex.addDrive(googleDrive);
        googleDrive.addItem(designDocument);

        designDocument.addItem(wireframes);
        designDocument.addItem(prototypes);
        designDocument.addItem(mockup);

        Assert.assertEquals(3, designDocument.getChildItems().size());
    }
}
