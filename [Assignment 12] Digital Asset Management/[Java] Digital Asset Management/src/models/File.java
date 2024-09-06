package models;

import roles.Role;

public class File extends Store {
    
    public File(String name) {
        super(name);
    }

    @Override
    public void propagatePermission(User user, Role role) {
        // Do nothing, it has no child
    }

    @Override
    public void delete() {
        this.markAsDeleted();
    }  
}
