variable "github_owner" {
  description = "GitHub username or organization name"
  type        = string
}

variable "repositories" {
  description = "Map of repositories to create and manage"
  type = map(object({
    # Basic repository settings
    description = optional(string, "")
    visibility  = optional(string, "private")

    # Repository features
    has_issues      = optional(bool, true)
    has_discussions = optional(bool, false)
    has_projects    = optional(bool, false)
    has_wiki        = optional(bool, false)
    has_downloads   = optional(bool, false)

    # Initialize repository
    auto_init          = optional(bool, false)
    gitignore_template = optional(string, null)
    license_template   = optional(string, null)

    # Topics/tags
    topics = optional(list(string), [])

    # Merge settings
    allow_merge_commit     = optional(bool, true)
    allow_squash_merge     = optional(bool, true)
    allow_rebase_merge     = optional(bool, true)
    allow_auto_merge       = optional(bool, false)
    delete_branch_on_merge = optional(bool, true)

    # Merge commit settings
    merge_commit_title          = optional(string, "MERGE_MESSAGE")
    merge_commit_message        = optional(string, "PR_TITLE")
    squash_merge_commit_title   = optional(string, "COMMIT_OR_PR_TITLE")
    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")

    # Security
    vulnerability_alerts = optional(bool, true)
    archive_on_destroy   = optional(bool, true)

    # Template repository
    is_template = optional(bool, false)

    # Homepage
    homepage_url = optional(string, null)

    # Branch protection (optional)
    branch_protection = optional(object({
      pattern                         = string
      enforce_admins                  = optional(bool, false)
      require_signed_commits          = optional(bool, false)
      require_conversation_resolution = optional(bool, false)
      lock_branch                     = optional(bool, false)
      allows_force_pushes             = optional(bool, false)
      allows_deletions                = optional(bool, false)
      force_push_bypassers            = optional(list(string), [])

      required_status_checks = optional(object({
        strict   = bool
        contexts = list(string)
      }), null)

      required_pull_request_reviews = optional(object({
        dismiss_stale_reviews           = bool
        restrict_dismissals             = optional(bool, false)
        dismissal_restrictions          = optional(list(string), [])
        pull_request_bypassers          = optional(list(string), [])
        require_code_owner_reviews      = optional(bool, false)
        required_approving_review_count = number
        require_last_push_approval      = optional(bool, false)
      }), null)

      restrict_pushes = optional(object({
        blocks_creations = optional(bool, false)
        push_allowances  = optional(list(string), [])
      }), null)
    }), null)
  }))

  default = {}
}
