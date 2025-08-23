# Access Roles

## What is it?

An access role is a type of role that contains one or more privileges for use in a Snowflake account.

For example the privilege to `create database` on a Snowflake account is granted to the role `create_database`.

## Why access roles?

The reason that a privilege is granted to roles in this way is that it's nuch easier to look for roles and their grants to other roles and users than it is to search for direct privilege grants.

If you want to grant the privilege of `create database` then grant privilege to an access role first and then grant the access role rather than granting the privilege directly.

To maintain access roles, it's best to have them all be owned by and subordinate to a single role.

## Parent of all access role - `privilege_admin`

The role `privilege_admin` is the parent and owner of all access roles.
