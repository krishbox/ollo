# Access Roles

## What is it?

An access role is a type of role that contains one or more privileges for use in a Snowflake account.

For example the privilege to `create database` on a Snowflake account is granted to the role `create_database`.

## Why access roles?

The reason that a privilege is granted to roles in this way is that it's nuch easier to look for roles and their grants to other roles and users than it is to search for direct privilege grants.

If you want to grant the privilege of `create database` then grant privilege to an access role first and then grant the access role rather than granting the privilege directly.

To maintain access roles, it's best to have them all be owned by and subordinate to a single role.

The role `privilege_admin` is the parent and owner of all access roles.

---

## The `MANAGE GRANTS` Privilege

`MANAGE GRANTS` is a delegation privilege in Snowflake that allows administrative roles to manage security permissions. Its scope and impact depend on the assignment level:

### 1. Database-Level (`MANAGE GRANTS ON DATABASE`)
This privilege is assigned directly to the database administrator role (e.g. `atlassian_jira_admin`) inside `sources/definitions/databases.sql`:
* **Bypasses Object Ownership**: Normally, only the owner (the role that created an object) can grant or revoke privileges on it. With `MANAGE GRANTS`, the database administrator can manage access permissions for **any object within that database** (schemas, tables, stages, tasks, etc.), even if the object was created by a different developer/process role.
* **Scope Isolation**: This access control power is strictly locked to objects inside that specific database. The database admin cannot grant privileges on other databases, warehouses, integrations, or manage account-level users/roles.

### 2. Account-Level (`MANAGE GRANTS ON ACCOUNT`)
This privilege is encapsulated in the custom `manage_grants` access role and assigned to `privilege_admin` (defined in `bootstrap/access_role/account_privilege/manage_grants.sql`):
* **Global Access & Role Delegation**: Allows the role to grant and revoke any privilege on any object across the entire Snowflake account (databases, integrations, warehouses).
* **Workload Identity Role Management**: Enables the role to grant database roles to OIDC service users (such as your GitHub Actions deployment user `provisioner_user`), making CI/CD deployments completely passwordless and secure.
* **Equivalence**: This is the core privilege that powers the system-defined `SECURITYADMIN` role.

---

## 🔗 Related Resources
* **[Inherited Grants Guide](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/access_role/inherited_grants.md)**: Details on migrating from legacy Future Grants to Inherited Grants.
