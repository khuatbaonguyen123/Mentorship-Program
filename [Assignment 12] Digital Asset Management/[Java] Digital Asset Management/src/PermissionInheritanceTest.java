import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class PermissionInheritanceTest {

    private static User Alex, Jordan, Taylor;
    private static Drive oneDrive, googleDrive;

    @Before
    public void setUpUserDrive() {
        Alex = new User("Alex");
        Jordan = new User("Jordan");
        Taylor = new User("Taylor");

        googleDrive = new Drive("Google Drive");
        oneDrive = new Drive("One Drive");

        Alex.addDrive(googleDrive);
        Alex.addDrive(oneDrive);
    }
    
    @Test
    public void fileInheritPermissionFromParentDriveTest() {
        File marketingMaterials = new File("Marketing Materials.pdf");

        // Alex.addItem(marketingMaterials, googleDrive);
        googleDrive.addItem(marketingMaterials);

        // Check this logic later in the role's behavior test, now just assume we
        // can set permission for drive directly
        // Alex.grantPermission(Jordan, googleDrive, Permission.CONTRIBUTOR);

        googleDrive.addPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertTrue(marketingMaterials.checkPermission(Jordan) == Permission.CONTRIBUTOR);
    }

    @Test
    public void folderInheritPermissionFromParentDriveTest() {
        Folder designDocument = new Folder("Design Documents");

        googleDrive.addItem(designDocument);

        googleDrive.addPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, designDocument.checkPermission(Jordan));
    }

    @Test
    public void driveCannotInheritPermissionFromChildFolderTest() {
        Folder designDocument = new Folder("Design Documents");

        googleDrive.addItem(designDocument);

        googleDrive.addPermission(Taylor, Permission.READER);
        designDocument.addPermission(Taylor, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.READER, googleDrive.checkPermission(Taylor));
    }

    @Test
    public void driveCannotInheritPermissionFromChildFileTest() {
        File marketingMaterials = new File("Marketing Materials.pdf");

        googleDrive.addItem(marketingMaterials);

        googleDrive.addPermission(Jordan, Permission.CONTRIBUTOR);
        marketingMaterials.addPermission(Jordan, Permission.ADMIN);

        Assert.assertEquals(Permission.CONTRIBUTOR, googleDrive.checkPermission(Jordan));
    }

    @Test
    public void fileInheritPermissionFromParentFolderTest() {
        Folder designDocuments = new Folder("Design Document");
        File mockUp = new File("Mock Up.pdf");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(mockUp);

        designDocuments.addPermission(Taylor, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, mockUp.checkPermission(Taylor));
    }

    @Test
    public void folderInheritPermissionFromParentFolderTest() {
        Folder designDocuments = new Folder("Design Document");
        Folder wireFrames = new Folder("Wireframes");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(wireFrames);

        designDocuments.addPermission(Taylor, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, wireFrames.checkPermission(Taylor));
    }

    @Test
    public void parentFolderCannotInheritPermissionFromChildFolderTest() {
        Folder designDocuments = new Folder("Design Document");
        Folder wireFrames = new Folder("Wireframes");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(wireFrames);

        designDocuments.addPermission(Jordan, Permission.CONTRIBUTOR);
        wireFrames.addPermission(Jordan, Permission.ADMIN);

        Assert.assertEquals(Permission.CONTRIBUTOR, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void parentFolderCannotInheritPermissionFromChildFileTest() {
        Folder designDocuments = new Folder("Design Document");
        File mockUp = new File("Mock Up.pdf");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(mockUp);

        designDocuments.addPermission(Taylor, Permission.CONTRIBUTOR);
        mockUp.addPermission(Taylor, Permission.READER);

        Assert.assertEquals(Permission.CONTRIBUTOR, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void folderInheritPermissionFromGrandparentDriveTest() {
        Folder designDocuments = new Folder("Design Document");
        Folder wireFrames = new Folder("Wireframes");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(wireFrames);

        googleDrive.addPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, wireFrames.checkPermission(Jordan));
    }

    @Test
    public void fileInheritPermissionFromGrandparentDriveTest() {
        Folder designDocuments = new Folder("Design Document");
        File mockUp = new File("Mock Up.pdf");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(mockUp);

        googleDrive.addPermission(Jordan, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, mockUp.checkPermission(Jordan));
    }

    @Test
    public void fileInheritPermissionFromGrandparentFolderTest() {
        Folder designDocuments = new Folder("Design Document");
        Folder prototypes = new Folder("Prototypes");
        File blueprints = new File("Blueprints.docx");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(prototypes);
        prototypes.addItem(blueprints);

        designDocuments.addPermission(Taylor, Permission.CONTRIBUTOR);

        Assert.assertEquals(Permission.CONTRIBUTOR, blueprints.checkPermission(Taylor));
    }

    @Test
    public void folderCannotInheritPermissionFromSubfolderFileTest() {
        Folder designDocuments = new Folder("Design Document");
        Folder prototypes = new Folder("Prototypes");
        File blueprints = new File("Blueprints.docx");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(prototypes);
        prototypes.addItem(blueprints);

        designDocuments.addPermission(Alex, Permission.ADMIN);
        prototypes.addPermission(Alex, Permission.READER);
        blueprints.addPermission(Alex, Permission.CONTRIBUTOR);     
        
        Assert.assertEquals(Permission.ADMIN, designDocuments.checkPermission(Alex));
    }

    @Test
    public void driveCannotInheritPermissionFromGrandchildTest() {
        Folder designDocuments = new Folder("Design Document");
        Folder prototypes = new Folder("Prototypes");
        File blueprints = new File("Blueprints.docx");

        googleDrive.addItem(designDocuments);
        designDocuments.addItem(prototypes);
        prototypes.addItem(blueprints);

        googleDrive.addPermission(Jordan, Permission.CONTRIBUTOR);
        blueprints.addPermission(Jordan, Permission.READER);

        Assert.assertEquals(Permission.CONTRIBUTOR, googleDrive.checkPermission(Jordan));
    }
}
