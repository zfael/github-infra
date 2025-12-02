resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  # Repository features
  has_issues      = var.has_issues
  has_discussions = var.has_discussions
  has_projects    = var.has_projects
  has_wiki        = var.has_wiki
  has_downloads   = var.has_downloads

  # Initialize repository
  auto_init          = var.auto_init
  gitignore_template = var.gitignore_template
  license_template   = var.license_template

  # Topics/tags
  topics = var.topics

  # Merge settings
  allow_merge_commit     = var.allow_merge_commit
  allow_squash_merge     = var.allow_squash_merge
  allow_rebase_merge     = var.allow_rebase_merge
  allow_auto_merge       = var.allow_auto_merge
  delete_branch_on_merge = var.delete_branch_on_merge

  # Merge commit settings
  merge_commit_title          = var.merge_commit_title
  merge_commit_message        = var.merge_commit_message
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message

  # Security
  vulnerability_alerts = var.vulnerability_alerts
  archive_on_destroy   = var.archive_on_destroy

  # Template repository
  is_template = var.is_template

  # Homepage
  homepage_url = var.homepage_url
}
