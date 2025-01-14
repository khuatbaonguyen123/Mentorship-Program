package roles;

import interfaces.RoleBehavior;

public class ReaderRoleBehavior implements RoleBehavior{

    @Override
    public boolean canGrantPermission() {
        return false;
    }

    @Override
    public boolean canAdd() {
        return false;
    }

    @Override
    public boolean canModify() {
        return false;
    }

    @Override
    public boolean canDelete() {
        return false;
    }

    @Override
    public boolean canRead() {
        return true;
    }
}
