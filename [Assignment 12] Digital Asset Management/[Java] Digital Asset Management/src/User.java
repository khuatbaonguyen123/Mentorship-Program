import java.util.ArrayList;
import java.util.List;

public class User {

    private String name;
    private int id;
    private List<Drive> drives;

    public User(int id, String name) {
        this.id = id;
        this.name = name;
        drives = new ArrayList<>();
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setID(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public int getID() {
        return id;
    }

    public List<Drive> getDrives() {
        return this.drives;
    }

    public void addDrive(Drive drive) {
        drives.add(drive);
    }

}
