import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class PermissionInheritanceTest {

    private static User Alex, Jordan, Taylor;
    private static Drive oneDrive, googleDrive;

    private static Folder designDocuments, developmentFiles;
    private static File marketingMaterials;

    private static Folder wireframes, prototypes;
    private static File mockUp;

    private static Folder initialDrafts;
    private static File blueprints;

    @Before
    public void setUpUserDrive() {
        addDrivesToUser();
        addFolersAndFilesToDrive();
        addFoldersAndFilesToFolder();
        addFoldersAndFilesToSubfolder();
    }

    private void addDrivesToUser() {
        Alex = new User("Alex");
        Jordan = new User("Jordan");
        Taylor = new User("Taylor");

        googleDrive = new Drive("Google Drive");
        oneDrive = new Drive("One Drive");

        Alex.addDrive(googleDrive);
        Alex.addDrive(oneDrive);
    }

    private void addFolersAndFilesToDrive() {
        designDocuments = new Folder("Design Documents");
        developmentFiles = new Folder("Development Files");
        marketingMaterials = new File("Marketing Materials.pdf");

        googleDrive.addItem(designDocuments);
        googleDrive.addItem(developmentFiles);
        googleDrive.addItem(marketingMaterials); 
    }

    private void addFoldersAndFilesToFolder() {
        wireframes = new Folder("Wireframes");
        prototypes = new Folder("Prototypes");
        mockUp = new File("Mockup.png");

        designDocuments.addItem(wireframes);
        designDocuments.addItem(prototypes);
        designDocuments.addItem(mockUp);
    }

    private void addFoldersAndFilesToSubfolder() {
        initialDrafts = new Folder("Inital Drafts");
        blueprints = new File("Blueprints.docx");

        wireframes.addItem(initialDrafts);
        wireframes.addItem(blueprints);
    }

    @Test
    public void childItemsInheritPermissionFromParentDriveTest() {
        googleDrive.grantPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, designDocuments.checkPermission(Jordan));
        Assert.assertEquals(Permission.CONTRIBUTOR, developmentFiles.checkPermission(Jordan));
        Assert.assertEquals(Permission.CONTRIBUTOR, marketingMaterials.checkPermission(Jordan));
    }

    @Test
    public void driveCannotInheritPermissionFromChildItemTest() {
        designDocuments.grantPermission(Jordan, Permission.ADMIN);

        Assert.assertEquals(null, googleDrive.checkPermission(Jordan));
    }

    @Test
    public void grandchildItemInheritPermissionFromDriveTest() {
        googleDrive.grantPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, wireframes.checkPermission(Jordan));
    }

    @Test
    public void driveCannotInheritPermissionFromGrandchildItemTest() {
        wireframes.grantPermission(Jordan, Permission.READER);

        Assert.assertEquals(null, googleDrive.checkPermission(Jordan));
    }

    @Test
    public void childItemsInheritPermissionFromFolderTest() {
        designDocuments.grantPermission(Jordan, Permission.ADMIN);

        Assert.assertEquals(Permission.ADMIN, wireframes.checkPermission(Jordan));
        Assert.assertEquals(Permission.ADMIN, prototypes.checkPermission(Jordan));
        Assert.assertEquals(Permission.ADMIN, mockUp.checkPermission(Jordan));
    }

    @Test
    public void folderCannotInheritPermissionFromChildItemTest() {
        wireframes.grantPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(null, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void grandchildItemInheritPermissionFromFolderTest() {
        designDocuments.grantPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, initialDrafts.checkPermission(Jordan));
        Assert.assertEquals(Permission.CONTRIBUTOR, blueprints.checkPermission(Jordan));
    }

    @Test
    public void folderCannotInheritPermissionFromGrandchildItemTest() {
        initialDrafts.grantPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(null, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void permissionPropagationThroughHierarchyTest() {
        googleDrive.grantPermission(Taylor, Permission.READER);

        Assert.assertEquals(Permission.READER, designDocuments.checkPermission(Taylor));
        Assert.assertEquals(Permission.READER, developmentFiles.checkPermission(Taylor));
        Assert.assertEquals(Permission.READER, marketingMaterials.checkPermission(Taylor));

        Assert.assertEquals(Permission.READER, wireframes.checkPermission(Taylor));
        Assert.assertEquals(Permission.READER, prototypes.checkPermission(Taylor));
        Assert.assertEquals(Permission.READER, mockUp.checkPermission(Taylor));

        Assert.assertEquals(Permission.READER, initialDrafts.checkPermission(Taylor));
        Assert.assertEquals(Permission.READER, blueprints.checkPermission(Taylor));        
    }

    @Test
    public void childItemOverrideInheritedPermissionTest() {
        googleDrive.grantPermission(Taylor, Permission.READER);
        designDocuments.grantPermission(Taylor, Permission.ADMIN);

        Assert.assertEquals(Permission.ADMIN, designDocuments.checkPermission(Taylor));
    }

    @Test
    public void grandChildItemOverrideInheritedPermissionTest() {
        googleDrive.grantPermission(Taylor, Permission.READER);

        // wireframes is child of designDocuments so it's a grandchild of googleDrive
        wireframes.grantPermission(Taylor, Permission.ADMIN);

        Assert.assertEquals(Permission.ADMIN, wireframes.checkPermission(Taylor));
    }
}
