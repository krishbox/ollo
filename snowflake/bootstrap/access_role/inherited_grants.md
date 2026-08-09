# Migrating to Inherited Grants in Snowflake

This document outlines the benefits of using Snowflake's **Inherited Grants** feature and guides the migration from legacy **Future Grants** (`ON FUTURE`) for container-level access control.

---

## 🌟 What are Inherited Grants?

Inherited Grants allow you to define permissions once at a container level (Account, Database, or Schema) that automatically apply to **both all existing and all future objects** of a specified type within that container.

Instead of running separate commands for current objects and future objects, a single inherited grant manages both.

---

## ⚖️ Future Grants vs. Inherited Grants

| Feature | Future Grants (`GRANT SELECT ON FUTURE`) | Inherited Grants (`GRANT INHERITED SELECT`) |
| :--- | :--- | :--- |
| **Command Count** | **Two commands**: Requires `ON ALL` (for existing) and `ON FUTURE` (for future). | **One command**: A single statement covers both existing and future objects. |
| **Management** | Can lead to grant proliferation and metadata drift over time. | Idempotent, declarative, and scales cleanly at the container level. |
| **Auditability** | Difficult to track which objects got their grants from where. | Clear trace columns (`IS_INHERITED`, `INHERITED_FROM`) available in `SHOW GRANTS`. |
| **DDL Footprint** | Large SQL volume required to maintain the RBAC matrix. | Compact, readable, and highly maintainable DDL. |

---

## 🚀 Benefits of Inherited Grants

1. **Zero Maintenance for New Objects**: As new schemas, tables, views, or stages are created by ingestion tasks, they immediately inherit the baseline access without requiring any follow-up DDL.
2. **Elimination of Privilege Drift**: Ensures that all objects of a given type within a database or schema have identical security posture, preventing security gaps.
3. **Reduced Metadata Overhead**: Reduces the internal grant records Snowflake has to compile and evaluate, improving compile times for large schemas.
4. **Simplified Auditability**: Security auditors can query the container metadata to immediately know the baseline permissions, rather than scanning thousands of individual tables.

---

## 🛠️ Migration Guide

To migrate from legacy future/all grants to inherited grants, update your DDL as follows:

### Legcy Future Grant Pattern (Before)
```sql
-- 1. Grant to existing tables
GRANT SELECT ON ALL TABLES IN SCHEMA atlassian_jira.raw TO DATABASE ROLE atlassian_jira.raw__read;

-- 2. Grant to future tables
GRANT SELECT ON FUTURE TABLES IN SCHEMA atlassian_jira.raw TO DATABASE ROLE atlassian_jira.raw__read;
```

### Inherited Grant Pattern (After)
```sql
-- A single statement covers all current and future tables in the schema
GRANT INHERITED SELECT ON ALL TABLES IN SCHEMA atlassian_jira.raw TO DATABASE ROLE atlassian_jira.raw__read;
```

---

## ⚠️ Important Considerations

* **Usage is still required**: A database role or account role still requires the `USAGE` privilege on the parent database and schema to access the inherited objects.
* **No Inherited Ownership**: The `OWNERSHIP` privilege cannot be inherited; it must still be explicitly set or managed.
* **Container Admin Role**: The role executing the `GRANT INHERITED` statements must possess the `MANAGE GRANTS` privilege on the container (e.g. `atlassian_jira_admin` using `MANAGE GRANTS ON DATABASE`).
