package models;

import java.util.HashMap;
import java.util.Map;

import enums.Role;
import interfaces.RoleBehavior;
import roles.ReaderRoleBehavior;
import roles.ContributorRoleBehavior;
import roles.AdminRoleBehavior;

public class RoleBehaviorMap {
    private static final Map<Role, RoleBehavior> map = new HashMap<>();

    static {
        map.put(Role.ADMIN, new AdminRoleBehavior());
        map.put(Role.CONTRIBUTOR, new ContributorRoleBehavior());
        map.put(Role.READER, new ReaderRoleBehavior());
    }

    public static RoleBehavior getRoleBehavior(Role permission) {
        return map.get(permission);
    }
}
