package roles;

import java.util.HashMap;
import java.util.Map;

import interfaces.RoleBehavior;

public class RoleBehaviorMap {
    private static final Map<Role, RoleBehavior> map = new HashMap<>();

    static {
        map.put(Role.ADMIN, new AdminRoleBehavior());
        map.put(Role.CONTRIBUTOR, new ContributorRoleBehavior());
        map.put(Role.READER, new ReaderRoleBehavior());
    }

    public static RoleBehavior getRoleBehavior(Role role) {
        return map.get(role);
    }
}
