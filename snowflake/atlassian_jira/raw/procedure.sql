use role atlassian_jira__raw;
use database atlassian_jira;
use schema atlassian_jira.raw;

create or replace procedure atlassian_jira.raw.copy_data(table_name string, initialize boolean)
returns string
language python
resource_constraint=(architecture='x86')
-- external_access_integrations = (
--   atlassian_jira_delta_share
-- )
runtime_version = '3.13'
artifact_repository = snowflake.snowpark.pypi_shared_repository
packages = (
  'delta-sharing',
  'snowflake-snowpark-python',
  'pandas'
)
imports = (
  '@atlassian_jira.raw.delta_share/profile'
  )
handler = 'main'
execute as owner
as
$$
import os
import sys
import snowflake.snowpark as snowpark
import delta_sharing
import pandas as pd

def main(session: snowpark.Session, table_name: str, initialize: bool):
    # Setup Delta Share
    import_directory = sys._xoptions["snowflake_import_directory"]
    profile = os.path.join(import_directory, 'profile')
    delta_share = delta_sharing.SharingClient(profile)

    # Get share and schema
    share = delta_share.list_shares()[0]
    schema = delta_share.list_schemas(share)[0]

    # Create table access URL
    table_url = f"{profile}#{share.name}.{schema.name}.{table_name}"

    # Convention to create a version log table to save versions loaded
    version_log_table_name = f"{table_name}__version_log"

    # Get the current version of the table
    current_version = delta_sharing.get_table_version(table_url)
    version_df = pd.DataFrame({'version': [current_version]})

    if initialize:
        # load the table into a pandas dataframe, in memory
        df = delta_sharing.load_as_pandas(table_url, version=current_version)

        # Add CDF columns to setup incremental loads
        df['_change_type'] = 'snapshot'
        df['_commit_version'] = current_version
        df['_commit_timestamp'] = pd.Timestamp.utcnow()
        df['_loaded_at'] = pd.Timestamp.utcnow()
        auto_create_table = True
        overwrite = True
    else:
        # Query the existing table for max commit version
        max_version = 0
        max_version_df = session.sql(f"select max(VERSION) as MAX_VERSION from {version_log_table_name}").collect()

        if max_version_df and max_version_df[0]['MAX_VERSION'] is not None:
            max_version = int(max_version_df[0]['MAX_VERSION'])
        if current_version <= max_version:
            return f"table: {table_name}; version_table: {version_log_table_name}; rows: 0"
        df = delta_sharing.load_table_changes_as_pandas(
            table_url,
            starting_version=max_version+1,
            ending_version=current_version,
        )
        df['_loaded_at'] = pd.Timestamp.utcnow()
        auto_create_table = False
        overwrite = False

    # Write the data to the table
    session.write_pandas(
        df,
        table_name,
        chunk_size = 100000,
        parallel = 4,
        quote_identifiers = False,
        auto_create_table = auto_create_table,
        overwrite = overwrite,
    )

    # Write the version to the version log table
    session.write_pandas(
        version_df,
        version_log_table_name,
        chunk_size = 1,
        parallel = 1,
        quote_identifiers = False,
        auto_create_table = auto_create_table,
        overwrite = overwrite,
    )
    return f"table: {table_name}; version_table: {version_log_table_name}; rows: {len(df)}"
$$
;
