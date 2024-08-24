import java.util.ArrayList;
import java.util.List;

public class Folder extends Store {
    private List<Store> childrenStore;

    public Folder(String folderName) {
        super(folderName);
        childrenStore = new ArrayList<>();
    }

    public List<Store> getSubStores() {
        return this.childrenStore;
    }

    public void setSubStores(List<Store> subStores) {
        this.childrenStore = subStores;
    }

}
