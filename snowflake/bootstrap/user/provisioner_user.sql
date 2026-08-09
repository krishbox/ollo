use role user_admin;

create user if not exists provisioner_user
type = service
workload_identity = (
  type = oidc
  issuer = 'https://token.actions.githubusercontent.com'
    subject = 'repo:krishbox/ollo:ref:refs/heads/main'
  )
default_role = privilege_admin
;

grant role privilege_admin to user provisioner_user;
