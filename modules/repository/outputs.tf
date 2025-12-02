output "repository_id" {
  description = "The ID of the repository"
  value       = github_repository.this.id
}

output "repository_name" {
  description = "The name of the repository"
  value       = github_repository.this.name
}

output "full_name" {
  description = "The full name of the repository (owner/name)"
  value       = github_repository.this.full_name
}

output "html_url" {
  description = "The URL to the repository on GitHub"
  value       = github_repository.this.html_url
}

output "ssh_clone_url" {
  description = "The SSH clone URL for the repository"
  value       = github_repository.this.ssh_clone_url
}

output "http_clone_url" {
  description = "The HTTP clone URL for the repository"
  value       = github_repository.this.http_clone_url
}

output "default_branch" {
  description = "The default branch of the repository"
  value       = github_repository.this.default_branch
}

output "node_id" {
  description = "The Node ID of the repository"
  value       = github_repository.this.node_id
}
