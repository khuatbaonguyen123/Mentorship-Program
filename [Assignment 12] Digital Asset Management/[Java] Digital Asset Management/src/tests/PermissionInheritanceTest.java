package tests;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import roles.Role;
import models.Drive;
import models.File;
import models.Folder;
import models.User;

public class PermissionInheritanceTest {

    private User Alex, Jordan, Taylor;
    private Drive oneDrive, googleDrive;

    private Folder designDocuments, developmentFiles;
    private File marketingMaterials;

    private Folder wireframes, prototypes;
    private File mockUp;

    private Folder initialDrafts;
    private File blueprints;

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
        googleDrive.grantPermission(Jordan, Role.CONTRIBUTOR);

        Assert.assertEquals(Role.CONTRIBUTOR, designDocuments.checkPermission(Jordan));
        Assert.assertEquals(Role.CONTRIBUTOR, developmentFiles.checkPermission(Jordan));
        Assert.assertEquals(Role.CONTRIBUTOR, marketingMaterials.checkPermission(Jordan));
    }

    @Test
    public void driveCannotInheritPermissionFromChildItemTest() {
        designDocuments.grantPermission(Jordan, Role.ADMIN);

        Assert.assertEquals(null, googleDrive.checkPermission(Jordan));
    }

    @Test
    public void grandchildItemInheritPermissionFromDriveTest() {
        googleDrive.grantPermission(Jordan, Role.CONTRIBUTOR);

        Assert.assertEquals(Role.CONTRIBUTOR, wireframes.checkPermission(Jordan));
    }

    @Test
    public void driveCannotInheritPermissionFromGrandchildItemTest() {
        wireframes.grantPermission(Jordan, Role.READER);

        Assert.assertEquals(null, googleDrive.checkPermission(Jordan));
    }

    @Test
    public void childItemsInheritPermissionFromFolderTest() {
        designDocuments.grantPermission(Jordan, Role.ADMIN);

        Assert.assertEquals(Role.ADMIN, wireframes.checkPermission(Jordan));
        Assert.assertEquals(Role.ADMIN, prototypes.checkPermission(Jordan));
        Assert.assertEquals(Role.ADMIN, mockUp.checkPermission(Jordan));
    }

    @Test
    public void folderCannotInheritPermissionFromChildItemTest() {
        wireframes.grantPermission(Jordan, Role.CONTRIBUTOR);

        Assert.assertEquals(null, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void grandchildItemInheritPermissionFromFolderTest() {
        designDocuments.grantPermission(Jordan, Role.CONTRIBUTOR);

        Assert.assertEquals(Role.CONTRIBUTOR, initialDrafts.checkPermission(Jordan));
        Assert.assertEquals(Role.CONTRIBUTOR, blueprints.checkPermission(Jordan));
    }

    @Test
    public void folderCannotInheritPermissionFromGrandchildItemTest() {
        initialDrafts.grantPermission(Jordan, Role.CONTRIBUTOR);

        Assert.assertEquals(null, designDocuments.checkPermission(Jordan));
    }

    @Test
    public void permissionPropagationThroughHierarchyTest() {
        googleDrive.grantPermission(Taylor, Role.READER);

        Assert.assertEquals(Role.READER, designDocuments.checkPermission(Taylor));
        Assert.assertEquals(Role.READER, developmentFiles.checkPermission(Taylor));
        Assert.assertEquals(Role.READER, marketingMaterials.checkPermission(Taylor));

        Assert.assertEquals(Role.READER, wireframes.checkPermission(Taylor));
        Assert.assertEquals(Role.READER, prototypes.checkPermission(Taylor));
        Assert.assertEquals(Role.READER, mockUp.checkPermission(Taylor));

        Assert.assertEquals(Role.READER, initialDrafts.checkPermission(Taylor));
        Assert.assertEquals(Role.READER, blueprints.checkPermission(Taylor));        
    }

    @Test
    public void childItemOverrideInheritedPermissionTest() {
        googleDrive.grantPermission(Taylor, Role.READER);
        designDocuments.grantPermission(Taylor, Role.ADMIN);

        Assert.assertEquals(Role.ADMIN, designDocuments.checkPermission(Taylor));
    }

    @Test
    public void grandChildItemOverrideInheritedPermissionTest() {
        googleDrive.grantPermission(Taylor, Role.READER);

        // wireframes is child of designDocuments so it's a grandchild of googleDrive
        wireframes.grantPermission(Taylor, Role.ADMIN);

        Assert.assertEquals(Role.ADMIN, wireframes.checkPermission(Taylor));
    }
}
