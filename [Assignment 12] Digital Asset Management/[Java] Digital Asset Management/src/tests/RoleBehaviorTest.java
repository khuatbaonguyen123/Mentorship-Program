package tests;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import roles.Role;
import models.Drive;
import models.File;
import models.Folder;
import models.User;

public class RoleBehaviorTest {

    private User Alex, Jordan, Taylor;
    private Drive googleDrive;

    @Rule
    public ExpectedException expectedException = ExpectedException.none();

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

    @Test
    public void driveAdminCanViewDriveContentsTest() {
        Folder designDocuments = new Folder("Design Documents");
        File marketingMaterials = new File("Marketing Materials");

        Alex.addItem(designDocuments, googleDrive);
        Alex.addItem(marketingMaterials, googleDrive);

        Assert.assertTrue(Alex.canRead(googleDrive));

        Assert.assertTrue(Alex.canRead(designDocuments));
        Assert.assertTrue(Alex.canRead(marketingMaterials));
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

    @Test
    public void driveContributorCanViewDriveContentsTest() {
        Folder designDocuments = new Folder("Design Documents");
        File marketingMaterials = new File("Marketing Materials");

        Alex.addItem(designDocuments, googleDrive);
        Alex.addItem(marketingMaterials, googleDrive);

        Alex.grantPermission(Jordan, googleDrive, Role.CONTRIBUTOR);

        Assert.assertTrue(Jordan.canRead(googleDrive));

        Assert.assertTrue(Jordan.canRead(designDocuments));
        Assert.assertTrue(Jordan.canRead(marketingMaterials));
    }

    @Test
    public void driveContributorCanDeleteDriveTest() {
        Alex.grantPermission(Jordan, googleDrive, Role.CONTRIBUTOR);

        Jordan.deleteStore(googleDrive);

        Assert.assertTrue(googleDrive.isDeleted());
    }

    /*
     * Expect: Throw exception "User does not have the required permission to grant access."
     */
    @Test
    public void driveContributorCannotGrantPermissionForDriveTest() {
        Alex.grantPermission(Jordan, googleDrive, Role.CONTRIBUTOR);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to grant access.");

        Jordan.grantPermission(Taylor, googleDrive, Role.READER);
    }

    @Test
    public void driveReaderCanViewDriveContentsTest() {
        Folder designDocuments = new Folder("Design Documents");
        File marketingMaterials = new File("Marketing Materials");

        Alex.addItem(designDocuments, googleDrive);
        Alex.addItem(marketingMaterials, googleDrive);

        Alex.grantPermission(Taylor, googleDrive, Role.READER);

        Assert.assertTrue(Taylor.canRead(googleDrive));

        Assert.assertTrue(Taylor.canRead(designDocuments));
        Assert.assertTrue(Taylor.canRead(marketingMaterials));
    }

    @Test
    public void driveReaderCannotAddItemsToDriveTest() {
        Alex.grantPermission(Taylor, googleDrive, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to add items to drive.");

        Taylor.addItem(new Folder("Design Documents"), googleDrive);
    }

    @Test
    public void driveReaderCannotModifyDriveNameTest() {
        Alex.grantPermission(Taylor, googleDrive, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to modify name.");

        Taylor.modifyName(googleDrive, "One Drive");
    }

    @Test
    public void driveReaderCannotDeleteDriveTest() {
        Alex.grantPermission(Taylor, googleDrive, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to delete.");

        Taylor.deleteStore(googleDrive);
    }

    @Test
    public void driveReaderCannotGrantPermissionForDriveTest() {
        Alex.grantPermission(Taylor, googleDrive, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to grant access.");

        Taylor.grantPermission(Jordan, googleDrive, Role.READER);
    }

    @Test
    public void folderAdminCanGrantPermissionForFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.grantPermission(Jordan, designDocuments, Role.CONTRIBUTOR);

        Assert.assertEquals(Role.CONTRIBUTOR, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void folderAdminCanAddItemsToFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        Folder wireframes = new Folder("Wireframes");
        File mockup = new File("Mockup.png");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.addItem(wireframes, designDocuments);
        Alex.addItem(mockup, designDocuments);

        Assert.assertTrue(designDocuments.contains(wireframes));
        Assert.assertTrue(designDocuments.contains(mockup));
    }

    @Test
    public void folderAdminCanModifyFolderNameTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.modifyName(designDocuments, "Design");

        Assert.assertEquals("Design", designDocuments.getName());
    }

    @Test
    public void folderAdminCanDeleteFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.deleteStore(designDocuments);

        Assert.assertTrue(designDocuments.isDeleted());
    }

    @Test
    public void folderAdminCanViewFolderContentsTest() {
        Folder designDocuments = new Folder("Design Documents");

        Folder wireframes = new Folder("Wireframes");
        File mockup = new File("Mockup.png");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.addItem(wireframes, designDocuments);
        Alex.addItem(mockup, designDocuments);

        Assert.assertTrue(Alex.canRead(wireframes));
        Assert.assertTrue(Alex.canRead(mockup));
    }

    @Test
    public void folderContributorCanAddItemsToFolderTest() {
        Folder designDocuments = new Folder("Design Documents");
        Folder prototypes = new Folder("Prototypes");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Jordan, designDocuments, Role.CONTRIBUTOR);

        Jordan.addItem(prototypes, designDocuments);

        Assert.assertTrue(designDocuments.contains(prototypes));
    }

    @Test
    public void folderContributorCanModifyFolderNameTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Jordan, designDocuments, Role.CONTRIBUTOR);

        Jordan.modifyName(designDocuments, "Design");

        Assert.assertEquals("Design", designDocuments.getName());
    }

    @Test
    public void folderContributorCanDeleteFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Jordan, designDocuments, Role.CONTRIBUTOR);

        Jordan.deleteStore(designDocuments);

        Assert.assertTrue(designDocuments.isDeleted());
    }

    @Test
    public void folderContributorCanViewFolderContentsTest() {
        Folder designDocuments = new Folder("Design Documents");

        Folder wireframes = new Folder("Wireframes");
        File mockup = new File("Mockup.png");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.addItem(wireframes, designDocuments);
        Alex.addItem(mockup, designDocuments);

        Alex.grantPermission(Jordan, designDocuments, Role.CONTRIBUTOR);
    
        Assert.assertTrue(Jordan.canRead(wireframes));
        Assert.assertTrue(Jordan.canRead(mockup));
    }

    @Test
    public void folderContributorCannotGrantPermissionForFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Jordan, designDocuments, Role.CONTRIBUTOR);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to grant access.");

        Jordan.grantPermission(Taylor, designDocuments, Role.READER);
    }

    @Test
    public void folderReaderCanViewFolderContentsTest() {
        Folder designDocuments = new Folder("Design Documents");

        Folder wireframes = new Folder("Wireframes");
        File mockup = new File("Mockup.png");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);

        Alex.addItem(wireframes, designDocuments);
        Alex.addItem(mockup, designDocuments);

        Alex.grantPermission(Taylor, designDocuments, Role.READER);

        Assert.assertTrue(Taylor.canRead(wireframes));
        Assert.assertTrue(Taylor.canRead(mockup));
    }

    @Test
    public void folderReaderCannotAddItemsToFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Taylor, designDocuments, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to add items to folder.");

        Taylor.addItem(new File("Mockup.png"), designDocuments);
    }

    @Test
    public void folderReaderCannotModifyFolderNameTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Taylor, designDocuments, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to modify name.");

        Taylor.modifyName(designDocuments, "Design");
    }

    @Test
    public void folderReaderCannotDeleteFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Taylor, designDocuments, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to delete.");

        Taylor.deleteStore(designDocuments);
    }

    @Test
    public void folderReaderCannotGrantPermissionForFolderTest() {
        Folder designDocuments = new Folder("Design Documents");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(designDocuments, googleDrive);
        Alex.grantPermission(Taylor, designDocuments, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to grant access.");

        Taylor.grantPermission(Jordan, designDocuments, Role.READER);
    }

    @Test
    public void fileAdminCanGrantPermissionForFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Taylor, marketingMaterials, Role.READER);

        Assert.assertEquals(Role.READER, marketingMaterials.checkPermission(Taylor));
    }

    @Test
    public void fileAdminCanModifyFileNameTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);

        Alex.modifyName(marketingMaterials, "Marketing");

        Assert.assertEquals("Marketing", marketingMaterials.getName());
    }

    @Test
    public void fileAdminCanViewFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);

        Assert.assertTrue(Alex.canRead(marketingMaterials));
    }

    @Test
    public void fileAdminCanDeleteFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);

        Alex.deleteStore(marketingMaterials);

        Assert.assertTrue(marketingMaterials.isDeleted());
    }

    @Test
    public void fileContributorCanModifyFileNameTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Jordan, marketingMaterials, Role.CONTRIBUTOR);

        Jordan.modifyName(marketingMaterials, "Marketing");

        Assert.assertEquals("Marketing", marketingMaterials.getName());
    }

    @Test
    public void fileContributorCanViewFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Jordan, marketingMaterials, Role.CONTRIBUTOR);

        Assert.assertTrue(Jordan.canRead(marketingMaterials));
    }

    @Test
    public void fileContributorCanDeleteFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Jordan, marketingMaterials, Role.CONTRIBUTOR);

        Jordan.deleteStore(marketingMaterials);

        Assert.assertTrue(marketingMaterials.isDeleted());
    }

    @Test
    public void fileContributorCannotGrantPermissionForFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Jordan, marketingMaterials, Role.CONTRIBUTOR);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to grant access.");

        Jordan.grantPermission(Taylor, marketingMaterials, Role.READER);
    }

    @Test
    public void fileReaderCanViewFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Taylor, marketingMaterials, Role.READER);

        Assert.assertTrue(Taylor.canRead(marketingMaterials));
    }

    @Test
    public void fileReaderCannotModifyFileNameTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Taylor, marketingMaterials, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to modify name.");

        Taylor.modifyName(marketingMaterials, "Design");
    }

    @Test
    public void fileReaderCannotDeleteFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Taylor, marketingMaterials, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to delete.");

        Taylor.deleteStore(marketingMaterials);
    }

    @Test
    public void fileReaderCannotGrantPermissionForFileTest() {
        File marketingMaterials = new File("Marketing Materials");

        // Alex has admin role for drive so he also has admin role for items in drive (Permission Inheritance)
        Alex.addItem(marketingMaterials, googleDrive);
        Alex.grantPermission(Taylor, marketingMaterials, Role.READER);

        expectedException.expect(IllegalStateException.class);
        expectedException.expectMessage("User does not have the required permission to grant access.");

        Taylor.grantPermission(Jordan, marketingMaterials, Role.READER);
    }
}
