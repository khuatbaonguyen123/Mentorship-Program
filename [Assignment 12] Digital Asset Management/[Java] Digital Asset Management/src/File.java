public class File extends Item {
    
    public File(String name) {
        super(name);
    }

    @Override
    public void propagatePermission(User user, Permission permission) {
        // Do nothing, it has no child
    }
    
}
