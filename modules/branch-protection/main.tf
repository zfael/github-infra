resource "github_branch_protection" "this" {
  repository_id = var.repository_id
  pattern       = var.pattern

  # Enforce rules for administrators
  enforce_admins = var.enforce_admins

  # Require signed commits
  require_signed_commits = var.require_signed_commits

  # Required status checks
  dynamic "required_status_checks" {
    for_each = var.required_status_checks != null ? [var.required_status_checks] : []
    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  # Required pull request reviews
  dynamic "required_pull_request_reviews" {
    for_each = var.required_pull_request_reviews != null ? [var.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      restrict_dismissals             = required_pull_request_reviews.value.restrict_dismissals
      dismissal_restrictions          = required_pull_request_reviews.value.dismissal_restrictions
      pull_request_bypassers          = required_pull_request_reviews.value.pull_request_bypassers
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      require_last_push_approval      = required_pull_request_reviews.value.require_last_push_approval
    }
  }

  # Push restrictions
  dynamic "restrict_pushes" {
    for_each = var.restrict_pushes != null ? [var.restrict_pushes] : []
    content {
      blocks_creations = restrict_pushes.value.blocks_creations
      push_allowances  = restrict_pushes.value.push_allowances
    }
  }

  # Force push restrictions
  allows_force_pushes = var.allows_force_pushes

  # Allow deletions
  allows_deletions = var.allows_deletions

  # Require conversation resolution
  require_conversation_resolution = var.require_conversation_resolution

  # Lock branch (read-only)
  lock_branch = var.lock_branch

  # Force push bypassers
  force_push_bypassers = var.force_push_bypassers
}
