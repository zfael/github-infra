provider "github" {
  # Authentication via GITHUB_TOKEN environment variable
  # Set this before running Terraform:
  # export GITHUB_TOKEN="your_personal_access_token"

  # The token needs the following scopes:
  # - repo (Full control of private repositories)
  # - admin:repo_hook (Full control of repository hooks)
  # - delete_repo (Delete repositories)

  owner = var.github_owner
}
