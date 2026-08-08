# Integrating with Atlassian Jira Cloud Enterprise Version

[Source Files](https://github.com/krishbox/ollo/tree/main/snowflake/atlassian_jira)

## DCM Database Change Management Deployment

This repository uses Snowflake Database Change Management (DCM) to manage database, compute, staging, task, and procedure schemas declaratively.

### Prerequisites

1. **Set Default Snowflake CLI Connection**:
   Ensure your target Snowflake connection (`FXB49207`) is configured as the default connection:
   ```bash
   snow connection set-default FXB49207
   ```

2. **Wake up Compute Warehouse**:
   If the default session warehouse (`hopper`) is suspended, wake it up (since it is configured to use least-privileged authentication parameters):
   ```bash
   snow sql -q "alter warehouse hopper resume;"
   ```

---

### Deployment Runbook

#### 1. Development (DEV Target)

Execute the pre-flight check, deploy the declarative definitions, and run target-specific post-deploy file staging and role grants:

```bash
# Generate the plan
snow dcm plan --target DEV

# Deploy the changes
snow dcm deploy --target DEV

# Run post-deployment staging and integration role grants
snow sql -f deploy/post_deploy/dev.sql
```

#### 2. Production (PROD Target)

Execute the plan and deployment for the isolated production target metadata:

```bash
# Generate the plan
snow dcm plan --target PROD

# Deploy the changes
snow dcm deploy --target PROD

# Run post-deployment staging and integration role grants
snow sql -f deploy/post_deploy/prod.sql
```

---

### Project Structure & Organization

* **`manifest.yml`**: Defines target accounts and deployment environment variables.
* **`pre_deploy.sql`**: Consolidated script auto-discovered and run by DCM to establish database containers, integrations, and network rules.
* **`deploy/pre_deploy/`**: Database-specific sub-scripts that assemble the pre-deploy file.
* **`deploy/post_deploy/`**: Environment-specific SQL scripts to upload the Delta Sharing credentials profile to the stage and grant usage role privileges to database roles.
* **`bootstrap/`**: Account-level one-time security and administration setup scripts.
* **`sources/definitions/`**: Declarative DDL definitions for databases, schemas, procedures, tasks, stages, and compute warehouses.
