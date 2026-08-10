-- =====================================================================
-- STEP: Upload Atlassian Delta Sharing Profile to stage
-- NOTE: Run these commands manually from your local command line terminal
--       using SnowSQL or Snowflake CLI, as they read files from your laptop.
-- =====================================================================

-- For DEV environment:
-- use role atlassian_jira_admin;
-- put 'file:///Users/krishna/Documents/projects/snowflake_jira_delta_share/canvadev/profile' @atlassian_jira.raw.delta_share/ auto_compress=false overwrite=true;

-- For PROD environment:
-- use role atlassian_jira_admin;
-- put 'file:///Users/krishna/Documents/projects/snowflake_jira_delta_share/canva/profile' @atlassian_jira.raw.delta_share/ auto_compress=false overwrite=true;
