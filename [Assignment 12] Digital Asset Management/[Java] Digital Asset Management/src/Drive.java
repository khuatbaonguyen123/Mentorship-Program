import java.util.ArrayList;
import java.util.List;

public class Drive {

    private int id;
    private String name;
    private List<Folder> folders;
    private List<File> files;

    public Drive(int id, String name) {
        this.id = id;
        this.name = name;
        folders = new ArrayList<>();
        files = new ArrayList<>();
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Folder> getFolders() {
        return folders;
    }

    public List<File> getFiles() {
        return files;
    }

    public void addFolder(Folder folder) {
        folders.add(folder);
    }

    public void addFile(File file) {
        files.add(file);
    }

}
