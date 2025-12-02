output "repositories" {
  description = "Map of created repositories with their details"
  value = {
    for name, repo in module.repositories : name => {
      id             = repo.repository_id
      full_name      = repo.full_name
      html_url       = repo.html_url
      ssh_clone_url  = repo.ssh_clone_url
      http_clone_url = repo.http_clone_url
      default_branch = repo.default_branch
    }
  }
}

output "repository_urls" {
  description = "Map of repository names to their GitHub URLs"
  value = {
    for name, repo in module.repositories : name => repo.html_url
  }
}

output "protected_branches" {
  description = "Map of repositories with branch protection enabled"
  value = {
    for name, protection in module.branch_protection : name => {
      pattern       = protection.pattern
      repository_id = protection.repository_id
    }
  }
}
