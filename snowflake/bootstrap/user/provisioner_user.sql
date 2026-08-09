use role sysadmin;

create user if not exists provisioner_user
type = service
workload_identity = (
  type = oidc
  issuer = 'https://token.actions.githubusercontent.com'
    subject = 'repo:krishbox/ollo:ref:refs/heads/main'
  )
default_role = sysadmin
;

grant role sysadmin to user provisioner_user;
