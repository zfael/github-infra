output "branch_protection_id" {
  description = "The ID of the branch protection rule"
  value       = github_branch_protection.this.id
}

output "pattern" {
  description = "The protected branch pattern"
  value       = github_branch_protection.this.pattern
}

output "repository_id" {
  description = "The repository ID this protection applies to"
  value       = github_branch_protection.this.repository_id
}
