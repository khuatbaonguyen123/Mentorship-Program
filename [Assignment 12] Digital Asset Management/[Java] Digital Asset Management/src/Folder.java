import java.util.List;
import java.util.ArrayList;

public class Folder {

    private int id;
    private String name;
    private List<Folder> folders;
    private List<File> files;

    public Folder(int id, String name) {
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

    public void addFolder(Folder folder) {
        folders.add(folder);
    }

    public List<Folder> getSubFolders() {
        return folders;
    }

    public void addFile(File file) {
        files.add(file);
    }

    public List<File> getFiles() {
        return files;
    }

}
