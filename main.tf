# Create all repositories
module "repositories" {
  source   = "./modules/repository"
  for_each = var.repositories

  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility

  # Repository features
  has_issues      = each.value.has_issues
  has_discussions = each.value.has_discussions
  has_projects    = each.value.has_projects
  has_wiki        = each.value.has_wiki
  has_downloads   = each.value.has_downloads

  # Initialize repository
  auto_init          = each.value.auto_init
  gitignore_template = each.value.gitignore_template
  license_template   = each.value.license_template

  # Topics/tags
  topics = each.value.topics

  # Merge settings
  allow_merge_commit     = each.value.allow_merge_commit
  allow_squash_merge     = each.value.allow_squash_merge
  allow_rebase_merge     = each.value.allow_rebase_merge
  allow_auto_merge       = each.value.allow_auto_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge

  # Merge commit settings
  merge_commit_title          = each.value.merge_commit_title
  merge_commit_message        = each.value.merge_commit_message
  squash_merge_commit_title   = each.value.squash_merge_commit_title
  squash_merge_commit_message = each.value.squash_merge_commit_message

  # Security
  vulnerability_alerts = each.value.vulnerability_alerts
  archive_on_destroy   = each.value.archive_on_destroy

  # Template repository
  is_template = each.value.is_template

  # Homepage
  homepage_url = each.value.homepage_url
}

# Create branch protection rules for repositories that have them defined
module "branch_protection" {
  source   = "./modules/branch-protection"
  for_each = { for k, v in var.repositories : k => v if v.branch_protection != null }

  repository_id = module.repositories[each.key].repository_id
  pattern       = each.value.branch_protection.pattern

  enforce_admins                  = each.value.branch_protection.enforce_admins
  require_signed_commits          = each.value.branch_protection.require_signed_commits
  require_conversation_resolution = each.value.branch_protection.require_conversation_resolution
  lock_branch                     = each.value.branch_protection.lock_branch
  allows_force_pushes             = each.value.branch_protection.allows_force_pushes
  allows_deletions                = each.value.branch_protection.allows_deletions
  force_push_bypassers            = each.value.branch_protection.force_push_bypassers

  required_status_checks        = each.value.branch_protection.required_status_checks
  required_pull_request_reviews = each.value.branch_protection.required_pull_request_reviews
  restrict_pushes               = each.value.branch_protection.restrict_pushes
}
