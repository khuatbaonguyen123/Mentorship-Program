package tests;

import org.junit.Assert;
import org.junit.Test;

import models.Drive;
import models.File;
import models.Folder;
import models.User;

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

        googleDrive.addStore(designDocument);
        googleDrive.addStore(developmentFiles);
        googleDrive.addStore(marketingMaterials);
        
        Assert.assertEquals(3, googleDrive.getChildStores().size());
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
        googleDrive.addStore(designDocument);

        designDocument.addStore(wireframes);
        designDocument.addStore(prototypes);
        designDocument.addStore(mockup);

        Assert.assertEquals(3, designDocument.getChildStores().size());
    }
}
