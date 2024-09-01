package tests;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import roles.Role;
import models.Drive;
import models.File;
import models.Folder;
import models.User;

public class RoleBehaviorTest {

    private User Alex, Jordan, Taylor;
    private Drive googleDrive;

    @Before
    public void setUpUserDrive() {
        Alex = new User("Alex");
        Jordan = new User("Jordan");
        Taylor = new User("Taylor");

        googleDrive = new Drive("Google Drive");

        Alex.addDrive(googleDrive);
    }

    @Test
    public void ownerHasAdminPermissionTest() {        
        Assert.assertEquals(Alex, googleDrive.getOwner());
        Assert.assertEquals(Role.ADMIN, googleDrive.checkPermission(Alex));
    }
    
    @Test
    public void driveAdminCanGrantPermissionForDriveTest() {
        Alex.grantPermission(Jordan, googleDrive, Role.CONTRIBUTOR);

        Assert.assertEquals(Role.CONTRIBUTOR, googleDrive.checkPermission(Jordan));
    }

    @Test
    public void driveAdminCanAddItemsToDriveTest() {
        Folder designDocuments = new Folder("Design Documents");
        File marketingMaterials = new File("Marketing Materials");

        Alex.addItem(designDocuments, googleDrive);
        Alex.addItem(marketingMaterials, googleDrive);

        Assert.assertEquals(2, googleDrive.getChildItems().size());

        Assert.assertEquals(googleDrive, designDocuments.getParentStore());
        Assert.assertEquals(googleDrive, marketingMaterials.getParentStore());
    }

    @Test
    public void driveAdminCanModifyDriveNameTest() {
        Alex.modifyName(googleDrive, "One Drive");

        Assert.assertEquals("One Drive", googleDrive.getName());
    }

    @Test
    public void driveAdminCanDeleteDriveTest() {
        Alex.deleteStore(googleDrive);

        Assert.assertTrue(googleDrive.isDeleted());
    }

    /*
     * I don't know how to write tests and implemet read behavior, this concept is so abstract
     */
    @Test
    public void driveAdminCanViewDriveContentsTest() {
        
    }

    @Test
    public void driveContributorCanAddItemsToDriveTest() {
        Alex.grantPermission(Jordan, googleDrive, Role.CONTRIBUTOR);

        Folder developmentFiles = new Folder("Development Files");

        Jordan.addItem(developmentFiles, googleDrive);

        Assert.assertTrue(googleDrive.contains(developmentFiles));
        Assert.assertEquals(googleDrive, developmentFiles.getParentStore());
    }

    @Test
    public void driveContributorCanModifyDriveNameTest() {
        Alex.grantPermission(Jordan, googleDrive, Role.CONTRIBUTOR);

        Jordan.modifyName(googleDrive, "One Drive");

        Assert.assertEquals("One Drive", googleDrive.getName());
    }
}
