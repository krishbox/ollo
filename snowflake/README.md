# Integrating with Atlassian Jira Cloud Enterprise Version

[Source Files](https://github.com/krishbox/ollo/tree/main/snowflake/atlassian_jira)

---

## 🛠️ Bootstrapping Setup

The one-time first-run administration and security setup is separated from the deployment pipeline.

### 1. Local Development (Key-Pair Authentication)
To run administrative and bootstrap commands locally without browser logins or entering passwords:
* Follow the step-by-step instructions in **[`bootstrap/README.md`](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/README.md)** to generate your RSA keys and configure your connection.

### 2. GitHub Actions (Workload Identity Federation / OIDC)
To set up secretless authentication for the deployment pipeline:
1. Open and customize **[`bootstrap/user/provisioner_user.sql`](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/user/provisioner_user.sql)**.
2. Execute the script in Snowflake as `USER_ADMIN` to create the OIDC service user.

---

## 🚀 CI/CD Deployment Pipeline

Once bootstrapping is complete, the continuous deployment pipeline is managed automatically via GitHub Actions:
* **Workflow Configuration**: **[`.github/workflows/deploy.yml`](file:///Users/krishna/Documents/projects/ollo/snowflake/.github/workflows/deploy.yml)**.
* **Trigger Conditions**: Runs conditionally whenever changes occur to:
  * `manifest.yml`
  * `pre_deploy.sql`
  * `sources/**`
  * `deploy/**`
* **Environments**:
  * Pushing to `main` targets **PROD** and uses `deploy/post_deploy/prod.sql`.
  * Pull requests or pushes to other branches target **DEV** and use `deploy/post_deploy/dev.sql`.

---

## 💻 Manual Deployment Runbook

If you need to deploy manually from your laptop using your key-pair connection:

1. **Wake up Compute Warehouse**:
   ```bash
   snow sql -q "alter warehouse hopper resume;"
   ```

2. **Deploy to DEV**:
   ```bash
   # Run pre-deploy DDL
   snow sql -f pre_deploy.sql
   # Deploy schema definitions
   snow dcm plan --target DEV
   snow dcm deploy --target DEV
   # Run post-deploy file uploads
   snow sql -f deploy/post_deploy/dev.sql
   ```

3. **Deploy to PROD**:
   ```bash
   # Run pre-deploy DDL
   snow sql -f pre_deploy.sql
   # Deploy schema definitions
   snow dcm plan --target PROD
   snow dcm deploy --target PROD
   # Run post-deploy file uploads
   snow sql -f deploy/post_deploy/prod.sql
   ```

---

## 📁 Project Structure & Organization

* **`manifest.yml`**: Defines target accounts and deployment environment variables.
* **`pre_deploy.sql`**: Consolidated script auto-discovered and run by DCM to establish database containers, integrations, and network rules.
* **`deploy/pre_deploy/`**: Database-specific sub-scripts that assemble the pre-deploy file.
* **`deploy/post_deploy/`**: Environment-specific SQL scripts to upload the Delta Sharing credentials profile to the stage and grant usage role privileges to database roles.
* **`bootstrap/`**: Account-level one-time security and administration setup scripts (contains **[`bootstrap/README.md`](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/README.md)** and the **[`bootstrap/create_or_alter.md`](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/create_or_alter.md)** guide).
* **`sources/definitions/`**: Declarative DDL definitions for databases, schemas, procedures, tasks, stages, and compute warehouses.
