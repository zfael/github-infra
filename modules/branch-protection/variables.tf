variable "repository_id" {
  description = "The ID of the repository"
  type        = string
}

variable "pattern" {
  description = "The branch pattern to protect (e.g., 'main', 'develop', 'release/*')"
  type        = string
}

variable "enforce_admins" {
  description = "Enforce all configured restrictions for administrators"
  type        = bool
  default     = false
}

variable "require_signed_commits" {
  description = "Require signed commits"
  type        = bool
  default     = false
}

variable "required_status_checks" {
  description = "Required status checks configuration"
  type = object({
    strict   = bool           # Require branches to be up to date before merging
    contexts = list(string)   # List of status checks that must pass
  })
  default = null
}

variable "required_pull_request_reviews" {
  description = "Required pull request reviews configuration"
  type = object({
    dismiss_stale_reviews           = bool         # Dismiss approved reviews when new commits are pushed
    restrict_dismissals             = bool         # Restrict who can dismiss pull request reviews
    dismissal_restrictions          = list(string) # List of users/teams who can dismiss reviews
    pull_request_bypassers          = list(string) # List of users/teams who can bypass pull request requirements
    require_code_owner_reviews      = bool         # Require review from code owners
    required_approving_review_count = number       # Number of approving reviews required (1-6)
    require_last_push_approval      = bool         # Require approval of the most recent push
  })
  default = null
}

variable "restrict_pushes" {
  description = "Restrict who can push to matching branches"
  type = object({
    blocks_creations = bool         # Block creation of matching branches
    push_allowances  = list(string) # List of users/teams allowed to push
  })
  default = null
}

variable "allows_force_pushes" {
  description = "Allow force pushes to the branch"
  type        = bool
  default     = false
}

variable "allows_deletions" {
  description = "Allow deletion of the branch"
  type        = bool
  default     = false
}

variable "require_conversation_resolution" {
  description = "Require all conversations to be resolved before merging"
  type        = bool
  default     = false
}

variable "lock_branch" {
  description = "Lock the branch (make it read-only)"
  type        = bool
  default     = false
}

variable "force_push_bypassers" {
  description = "List of users/teams who can force push"
  type        = list(string)
  default     = []
}
