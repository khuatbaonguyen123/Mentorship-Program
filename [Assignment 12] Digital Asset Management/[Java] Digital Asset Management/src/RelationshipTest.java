import org.junit.Test;
import org.junit.Assert;
import java.util.Map;
import java.util.HashMap;

public class RelationshipTest {

    private static User initUserData() {
        User user = new User(1, "Nguyen");

        user.addDrive(new Drive(1, "Google Drive"));
        user.addDrive(new Drive(2, "One Drive"));

        return user;
    }

    @Test
    public void UserHasMultipleDrivesTest() {
        User user = initUserData();
        Assert.assertEquals(2, user.getDrives().size());
    }

    @Test
    public void DriveHasMultipleFoldersTest() {
        Drive drive = new Drive(1, "Google Drive");

        drive.addFolder(new Folder(1, "Mentorship"));
        drive.addFolder(new Folder(7, "Plan for Life"));

        Assert.assertEquals(2, drive.getFolders().size());
    }

    // search files and folders - common file extension icon
    // 

    @Test
    public void DriveHasMultipleFilesTest() {
        Map<String, String> fileExtensionIcons = new HashMap<>();

        fileExtensionIcons.put("pdf", "/source/pdficon.png");
        fileExtensionIcons.put("docx", "/source/docxicon.png");

        Drive drive = new Drive(1, "Google Drive");

        drive.addFile(new File(11, "BABOK.pdf"));
        drive.addFile(new File(12, "Digital Asset Requirement.docx"));

        Assert.assertEquals(2, drive.getFiles().size());


    }

    @Test
    public void UserHasMultipleDrivesWithFoldersAndFilesTest() {
        User user = new User(1, "Nguyen");

        Drive drive1 = new Drive(1, "Google Drive");
        Drive drive2 = new Drive(2, "One Drive");

        drive1.addFolder(new Folder(1, "Mentorship"));
        drive1.addFolder(new Folder(7, "Plan for Life"));
        drive1.addFile(new File(11, "BABOK.pdf"));
        drive1.addFile(new File(12, "Digital Asset Requirement.docx"));

        drive2.addFolder(new Folder(10, "Business Analysis"));
        drive2.addFolder(new Folder(13, "New Year New Me"));

        user.addDrive(drive1);
        user.addDrive(drive2);

        Assert.assertEquals(2, user.getDrives().size());
        Assert.assertEquals(2, user.getDrives().get(0).getFolders().size());
        Assert.assertEquals(2, user.getDrives().get(0).getFiles().size());
        Assert.assertEquals(2, user.getDrives().get(1).getFolders().size());
    }


    @Test
    public void FolderHasMultipleSubFoldersAndFilesTest() {
        User user = initUserData();

        Drive drive = user.getDrives().get(0);

        Folder mentorship = new Folder(1, "Mentorship");
        drive.addFolder(mentorship);

        mentorship.addFolder(new Folder(2, "Mentorship 2024"));
        mentorship.addFolder(new Folder(6, "Mentorship 2025"));

        mentorship.addFile(new File(5, "Participants.pdf"));

        Assert.assertEquals(2, mentorship.getSubFolders().size());
        Assert.assertEquals(1, mentorship.getFiles().size());
    }

    @Test
    public void FolderHasMultipleSubfoldersTest() {
        User user = initUserData();

        Drive drive = user.getDrives().get(0);

        Folder mentorship = new Folder(1, "Mentorship");
        drive.addFolder(mentorship);

        Folder mentorship2024 = new Folder(2, "Mentorship 2024");
        Folder mentorship2025 = new Folder(6, "Mentorship 2025");

        mentorship.addFolder(mentorship2024);
        mentorship.addFolder(mentorship2025);

        mentorship2024.addFile(new File(3, "mentorship2.docx"));
        mentorship2025.addFile(new File(4, "mentorship1.docx"));
        
        Assert.assertEquals(2, mentorship.getSubFolders().size());
        Assert.assertEquals(1, mentorship.getSubFolders().get(0).getFiles().size());
        Assert.assertEquals(1, mentorship.getSubFolders().get(1).getFiles().size());
    }

}
