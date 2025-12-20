use role atlassian_jira__raw;
use database atlassian_jira;
use schema atlassian_jira.raw;

create artifact repository if not exists atlassian_jira.raw.pypi_repository
type = pip
api_integration = pypi_integration
;
