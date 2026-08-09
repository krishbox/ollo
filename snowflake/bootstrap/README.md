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

1. Copy the contents of the public key file `~/.snowflake/snowflake_key.pub` (**exclude** the `-----BEGIN PUBLIC KEY-----` and `-----END PUBLIC KEY-----` header and footer lines).
2. Connect to Snowflake and run this SQL (replacing `admin` with your username and `<public_key_contents>` with your copied key):

```sql
ALTER USER admin SET RSA_PUBLIC_KEY = '<public_key_contents>';
```

---

### Step 3: Configure Local Connection

Update your Snowflake CLI configuration file (usually at `~/.snowflake/connections.toml` or `./connections.toml`) to reference the private key file:

```toml
[FXB49207]
account = "tib52397"
user = "admin"
private_key_path = "/Users/krishna/.snowflake/snowflake_key.p8"
```

Once saved, any local commands (like `snow sql` or `snow dcm`) will authenticate instantly without prompts!

---

## 🔗 Related Resources
* **[Create or Alter Guide](file:///Users/krishna/Documents/projects/ollo/snowflake/bootstrap/create_or_alter.md)**: Details on migrating legacy DDL scripts to declarative `create or alter` states.
