# Local Bootstrap: Setting Up Key-Pair Authentication

To run your first-run bootstrap scripts locally on your Mac without interactive browser logins or typing passwords, configure Key-Pair authentication.

---

### Step 1: Generate RSA Key Pair

Open your local terminal and run the following commands to generate the private and public keys:

```bash
# 1. Generate a private key (unencrypted for CLI use)
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out ~/.snowflake/snowflake_key.p8 -nocrypt

# 2. Generate the corresponding public key
openssl rsa -in ~/.snowflake/snowflake_key.p8 -pubout -out ~/.snowflake/snowflake_key.pub
```

> [!IMPORTANT]
> Keep `snowflake_key.p8` secure and do NOT commit it to your Git repository.

---

### Step 2: Assign Public Key to your Snowflake User

1. Format and copy the public key directly to your macOS clipboard by running this command in your terminal:
   ```bash
   grep -v "PUBLIC KEY" ~/.snowflake/snowflake_key.pub | tr -d '\n' | pbcopy
   ```
   *(This automatically strips the headers/footers, removes all newlines, and copies the clean string to your clipboard).*
2. Connect to Snowflake and run this SQL (pasting the copied key string inside the single quotes):

```sql
alter user admin set rsa_public_key = '<public_key_contents>';
```

---

### Step 3: Configure Local Connection

Update your Snowflake CLI configuration file (usually at `~/.snowflake/connections.toml` or `./connections.toml`) to reference the private key file:

```toml
[ollo-prod]
account = "tib52397"
user = "admin"
private_key_path = "/Users/krishna/.snowflake/snowflake_key.p8"
warehouse = "kilby"
role = "sysadmin"
```

Once saved, any local commands (like `snow sql` or `snow dcm`) will authenticate instantly without prompts!

## 🛠️ Manual Bootstrap Operations (One-time Setup)

Certain operations are privileged or rely on local files that cannot be executed in the automated cloud CI/CD pipelines:

### 1. Provisioning Integrations
Integrations are account-level objects that require `ACCOUNTADMIN` rights. Before running deployments, execute the files inside **[`bootstrap/integration/`](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/integration/)** manually in Snowsight or via SnowSQL.

### 2. Uploading the Delta Sharing Profile File
Because the credentials file is located on your local laptop, it must be uploaded to the stage manually. 

Execute the instructions in **[`bootstrap/integration/upload_profile.sql`](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/integration/upload_profile.sql)** from your local terminal to upload the file to your environment's stage:

```bash
# Example for DEV (run from your local machine):
snow sql -f bootstrap/integration/upload_profile.sql -x
```

---

## 🔗 Related Resources
* **[Create or Alter Guide](create_or_alter.md)**: Details on migrating legacy DDL scripts to declarative `create or alter` states.
* **[Account Setup Script](account_setup.sql)**: Account-level setup containing preview features activation and administrative setups.
