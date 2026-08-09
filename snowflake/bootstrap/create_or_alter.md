# Declarative State Management with `create or alter`

This document details the benefits of using Snowflake's native **`create or alter`** feature and guides the migration of bootstrap and companion scripts from legacy `create if not exists` DDL.

---

## 🌟 What is `create or alter`?

`create or alter` is a declarative SQL command in Snowflake that combines creation and modification logic. Instead of specifying *how* to change an object (imperative DDL), you define the *desired final state* of the object (declarative DDL).

Snowflake compares your definition with the active object in your account:
1. **If the object does not exist**: It creates it.
2. **If the object exists with different properties**: It applies `alter` statements to align the object with your definition.
3. **If the object matches**: It does nothing.

---

## ⚖️ `create if not exists` vs. `create or alter`

| Scenario | `create <object> if not exists` | `create or alter <object>` |
| :--- | :--- | :--- |
| **Object is missing** | Creates the object successfully. | Creates the object successfully. |
| **Object exists, properties changed** | **Ignored**: Properties are not updated (leads to configuration drift). | **Updated**: Aligns columns, sizes, limits, or configurations to match the new definition. |
| **State Preservation** | Preserved. | Preserved (does **not** drop/recreate; retains data, grants, and history). |
| **Errors on repeat runs** | None (idempotent, but ignores changes). | None (idempotent, applies updates). |

---

## 🚀 Key Benefits

1. **Eliminates Configuration Drift**: If you change properties (like a warehouse size, data retention days, or a task schedule), running the script will automatically apply those updates.
2. **Preserves Data and Permissions**: Unlike `create or replace` (which drops the object first, wiping data, historical logs, and grants), `create or alter` updates the object in-place.
3. **No Duplicate Logic**: Removes the need for separate first-run scripts (`create`) and subsequent change scripts (`alter`).

---

## 🛠️ Supported Objects in Our Setup

The following objects in our `bootstrap/` and `deploy/` scripts support `create or alter`:

* **Databases & Schemas**: Updates data retention time or object visibility.
* **Warehouses**: Updates sizes, max cluster counts, scaling policies, and auto-suspend limits.
* **Tasks**: Updates schedules, timeouts, and execution parameters.
* **Stages**: Updates encryption properties and directories.
* **Network Policies**: Updates allowed and blocked IP ranges.

---

## 📝 Migration Examples

### 1. Database and Schema Containers
#### Before (`if not exists`):
```sql
create database if not exists atlassian_jira;
```
*(If you want to change data retention from 1 day to 7 days later, this script will silently ignore the change).*

#### After (`create or alter`):
```sql
create or alter database atlassian_jira
  data_retention_time_in_days = 7;
```

### 2. Compute Warehouses
#### Before (`if not exists`):
```sql
create warehouse if not exists hopper;
```

#### After (`create or alter`):
```sql
create or alter warehouse hopper
  warehouse_size = 'small'
  auto_suspend = 180
  auto_resume = true;
```

---

## ⚠️ Current Limitations (Future Migration Candidates)

The following objects used in our project do **not** currently support `create or alter` in Snowflake. They must continue using their legacy syntax until Snowflake adds native support for them:

* **Integrations** (API and External Access Integrations): Must use `create ... if not exists`.
* **Network Rules**: Must use `create or replace`.
* **Artifact Repositories**: Must use `create ... if not exists`.
* **Users** (Service/OIDC Users): Must use `create user if not exists`.
