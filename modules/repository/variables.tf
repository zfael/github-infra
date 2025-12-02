variable "name" {
  description = "Name of the repository"
  type        = string
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = ""
}

variable "visibility" {
  description = "Visibility of the repository (public, private, or internal)"
  type        = string
  default     = "private"
}

variable "has_issues" {
  description = "Enable GitHub Issues"
  type        = bool
  default     = true
}

variable "has_discussions" {
  description = "Enable GitHub Discussions"
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Enable GitHub Projects"
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Enable GitHub Wiki"
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Enable downloads"
  type        = bool
  default     = false
}

variable "auto_init" {
  description = "Initialize repository with a README"
  type        = bool
  default     = false
}

variable "gitignore_template" {
  description = "Gitignore template to use (e.g., 'Node', 'Python', 'Go')"
  type        = string
  default     = null
}

variable "license_template" {
  description = "License template to use (e.g., 'mit', 'apache-2.0', 'gpl-3.0')"
  type        = string
  default     = null
}

variable "topics" {
  description = "List of topics for the repository"
  type        = list(string)
  default     = []
}

variable "allow_merge_commit" {
  description = "Allow merge commits"
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Allow squash merging"
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Allow rebase merging"
  type        = bool
  default     = true
}

variable "allow_auto_merge" {
  description = "Allow auto-merge on pull requests"
  type        = bool
  default     = false
}

variable "delete_branch_on_merge" {
  description = "Automatically delete head branches after pull requests are merged"
  type        = bool
  default     = true
}

variable "merge_commit_title" {
  description = "The default value for merge commit title (PR_TITLE or MERGE_MESSAGE)"
  type        = string
  default     = "MERGE_MESSAGE"
}

variable "merge_commit_message" {
  description = "The default value for merge commit message (PR_BODY, PR_TITLE, or BLANK)"
  type        = string
  default     = "PR_TITLE"
}

variable "squash_merge_commit_title" {
  description = "The default value for squash merge commit title (PR_TITLE or COMMIT_OR_PR_TITLE)"
  type        = string
  default     = "COMMIT_OR_PR_TITLE"
}

variable "squash_merge_commit_message" {
  description = "The default value for squash merge commit message (PR_BODY, COMMIT_MESSAGES, or BLANK)"
  type        = string
  default     = "COMMIT_MESSAGES"
}

variable "vulnerability_alerts" {
  description = "Enable security alerts for vulnerable dependencies"
  type        = bool
  default     = true
}

variable "archive_on_destroy" {
  description = "Archive the repository instead of deleting on destroy"
  type        = bool
  default     = true
}

variable "is_template" {
  description = "Make this repository a template repository"
  type        = bool
  default     = false
}

variable "homepage_url" {
  description = "URL of a page describing the project"
  type        = string
  default     = null
}
