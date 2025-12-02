# GitHub Infrastructure as Code

Terraform project to provision and manage GitHub repositories for personal accounts with declarative configuration and modular design.

## Features

- 🏗️ **Declarative Repository Management**: Define all repository settings in a single configuration file
- 🔒 **Branch Protection Rules**: Comprehensive branch protection with customizable security settings
- 🧩 **Modular Design**: Reusable modules for repositories and branch protection
- ☁️ **Terraform Cloud Integration**: Remote state management with Terraform Cloud free tier
- 🔐 **Security First**: Built-in defaults for security best practices
- 📝 **Fully Composable**: Each repository is independently configured

## Prerequisites

1. **GitHub Personal Access Token (PAT)**
   - Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Generate new token with the following scopes:
     - `repo` (Full control of private repositories)
     - `admin:repo_hook` (Full control of repository hooks)
     - `delete_repo` (Delete repositories)
   - Save the token securely - you'll need it for authentication

2. **Terraform Cloud Account** (Free)
   - Sign up at [app.terraform.io](https://app.terraform.io)
   - Create an organization
   - Update `versions.tf` with your organization name

3. **Terraform CLI**
   - Install Terraform >= 1.6.0
   - Download from [terraform.io](https://www.terraform.io/downloads)

## Project Structure

```
github-infra/
├── modules/
│   ├── repository/           # Repository creation module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── branch-protection/    # Branch protection module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf                   # Root module orchestration
├── variables.tf              # Root variables
├── outputs.tf                # Root outputs
├── providers.tf              # Provider configuration
├── versions.tf               # Terraform and provider versions
├── terraform.tfvars.example  # Example configuration
├── .gitignore               # Git ignore rules
└── README.md                # This file
```

## Setup

### 1. Clone and Configure

```bash
# Clone or navigate to this repository
cd github-infra

# Copy the example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your settings
vim terraform.tfvars
```

### 2. Configure Terraform Cloud

Edit `versions.tf` and replace `REPLACE_WITH_YOUR_ORG` with your Terraform Cloud organization name:

```hcl
cloud {
  organization = "your-terraform-cloud-org"
  
  workspaces {
    name = "github-infra"
  }
}
```

### 3. Set Environment Variables

```bash
# GitHub Personal Access Token
export GITHUB_TOKEN="your_github_personal_access_token"

# GitHub owner (your username) - alternative to setting in tfvars
export TF_VAR_github_owner="your-github-username"
```

### 4. Initialize Terraform

```bash
# Initialize Terraform (will prompt for Terraform Cloud login)
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt -recursive
```

## Usage

### Define Repositories

Edit `terraform.tfvars` to define your repositories:

```hcl
github_owner = "your-github-username"

repositories = {
  "my-project" = {
    description = "My awesome project"
    visibility  = "public"
    
    has_issues = true
    auto_init  = true
    
    gitignore_template = "Node"
    license_template   = "mit"
    topics             = ["nodejs", "api"]
    
    branch_protection = {
      pattern                         = "main"
      require_signed_commits          = true
      require_conversation_resolution = true
      
      required_pull_request_reviews = {
        required_approving_review_count = 1
        dismiss_stale_reviews           = true
      }
    }
  }
}
```

### Apply Configuration

```bash
# Preview changes
terraform plan

# Apply changes
terraform apply

# View outputs
terraform output
```

### Add a New Repository

1. Add a new entry to the `repositories` map in `terraform.tfvars`
2. Run `terraform plan` to preview
3. Run `terraform apply` to create the repository

### Remove a Repository

1. Remove the repository entry from `terraform.tfvars`
2. Run `terraform plan` to preview (repository will be archived by default)
3. Run `terraform apply` to archive the repository

## Configuration Reference

### Repository Settings

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `description` | string | `""` | Repository description |
| `visibility` | string | `"private"` | Repository visibility: `public`, `private`, or `internal` |
| `has_issues` | bool | `true` | Enable GitHub Issues |
| `has_discussions` | bool | `false` | Enable GitHub Discussions |
| `has_projects` | bool | `false` | Enable GitHub Projects |
| `has_wiki` | bool | `false` | Enable GitHub Wiki |
| `has_downloads` | bool | `false` | Enable downloads |
| `auto_init` | bool | `false` | Initialize with README |
| `gitignore_template` | string | `null` | Gitignore template (e.g., `"Node"`, `"Python"`, `"Go"`) |
| `license_template` | string | `null` | License template (e.g., `"mit"`, `"apache-2.0"`, `"gpl-3.0"`) |
| `topics` | list(string) | `[]` | Repository topics/tags |
| `allow_merge_commit` | bool | `true` | Allow merge commits |
| `allow_squash_merge` | bool | `true` | Allow squash merging |
| `allow_rebase_merge` | bool | `true` | Allow rebase merging |
| `allow_auto_merge` | bool | `false` | Allow auto-merge on pull requests |
| `delete_branch_on_merge` | bool | `true` | Automatically delete head branches after merge |
| `vulnerability_alerts` | bool | `true` | Enable security alerts |
| `archive_on_destroy` | bool | `true` | Archive instead of delete on destroy |
| `is_template` | bool | `false` | Make this a template repository |
| `homepage_url` | string | `null` | Repository homepage URL |

### Branch Protection Settings

Branch protection is optional. Omit the `branch_protection` block to create a repository without protection.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `pattern` | string | **required** | Branch pattern (e.g., `"main"`, `"develop"`) |
| `enforce_admins` | bool | `false` | Enforce rules for administrators |
| `require_signed_commits` | bool | `false` | Require signed commits |
| `require_conversation_resolution` | bool | `false` | Require conversation resolution before merge |
| `allows_force_pushes` | bool | `false` | Allow force pushes |
| `allows_deletions` | bool | `false` | Allow branch deletion |
| `lock_branch` | bool | `false` | Lock branch (read-only) |
| `required_status_checks` | object | `null` | Required status checks configuration |
| `required_pull_request_reviews` | object | `null` | Required PR reviews configuration |
| `restrict_pushes` | object | `null` | Push restrictions configuration |

#### Required Status Checks

```hcl
required_status_checks = {
  strict   = true                    # Require branches to be up to date
  contexts = ["ci/tests", "ci/lint"] # Status checks that must pass
}
```

#### Required Pull Request Reviews

```hcl
required_pull_request_reviews = {
  required_approving_review_count = 2    # Number of required approvals (1-6)
  dismiss_stale_reviews           = true # Dismiss approvals on new commits
  require_code_owner_reviews      = true # Require review from code owners
  require_last_push_approval      = true # Require approval of latest push
}
```

## Common Workflows

### Strict Security Repository

```hcl
"secure-app" = {
  description = "High-security application"
  visibility  = "private"
  
  vulnerability_alerts = true
  
  branch_protection = {
    pattern                         = "main"
    enforce_admins                  = true
    require_signed_commits          = true
    require_conversation_resolution = true
    
    required_pull_request_reviews = {
      required_approving_review_count = 2
      dismiss_stale_reviews           = true
      require_code_owner_reviews      = true
      require_last_push_approval      = true
    }
    
    required_status_checks = {
      strict   = true
      contexts = ["security-scan", "tests", "lint"]
    }
  }
}
```

### Simple Personal Project

```hcl
"my-notes" = {
  description = "Personal notes"
  visibility  = "private"
  
  has_issues = true
  auto_init  = true
  
  topics = ["personal", "notes"]
  
  # No branch protection - simple repo
}
```

### Open Source Project

```hcl
"awesome-lib" = {
  description = "An awesome open source library"
  visibility  = "public"
  
  has_issues      = true
  has_discussions = true
  homepage_url    = "https://awesome-lib.dev"
  
  license_template   = "mit"
  gitignore_template = "Node"
  
  topics = ["javascript", "library", "open-source"]
  
  branch_protection = {
    pattern = "main"
    
    required_pull_request_reviews = {
      required_approving_review_count = 1
      dismiss_stale_reviews           = true
    }
    
    required_status_checks = {
      strict   = true
      contexts = ["tests", "lint"]
    }
  }
}
```

## Outputs

After applying, Terraform outputs the following information:

- `repositories`: Complete details of all created repositories
- `repository_urls`: Quick map of repository names to URLs
- `protected_branches`: List of repositories with branch protection

View outputs:

```bash
terraform output
terraform output repositories
terraform output repository_urls
```

## Security Best Practices

1. **Never commit sensitive data**
   - Keep `terraform.tfvars` out of version control (already in `.gitignore`)
   - Use environment variables for tokens
   - Rotate tokens regularly

2. **Use branch protection**
   - Always protect `main` and production branches
   - Require pull request reviews
   - Enable signed commits for sensitive repositories

3. **Enable security features**
   - Enable `vulnerability_alerts`
   - Use `private` visibility by default
   - Set `archive_on_destroy = true` to prevent accidental deletion

4. **Terraform Cloud security**
   - Enable 2FA on Terraform Cloud account
   - Use workspace permissions appropriately
   - Review state file access

## Troubleshooting

### Authentication Issues

```bash
# Verify token is set
echo $GITHUB_TOKEN

# Test GitHub API access
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user
```

### Terraform Cloud Login

```bash
# Login to Terraform Cloud
terraform login

# Or manually create ~/.terraform.d/credentials.tfrc.json
```

### State Issues

```bash
# Refresh state
terraform refresh

# View current state
terraform show

# Import existing repository (if needed)
terraform import 'module.repositories["repo-name"].github_repository.this' owner/repo-name
```

### Validation Errors

```bash
# Check configuration
terraform validate

# Format code
terraform fmt -recursive

# Show plan with detailed logs
TF_LOG=DEBUG terraform plan
```

## Maintenance

### Update Dependencies

```bash
# Update providers
terraform init -upgrade

# Check for updates
terraform version
```

### Backup State

Terraform Cloud automatically versions state. To download:

```bash
# Download state
terraform state pull > terraform.tfstate.backup
```

## Contributing

This is a personal infrastructure project. Feel free to fork and adapt for your own use.

## License

MIT License - Feel free to use this as a template for your own infrastructure.

## Resources

- [Terraform GitHub Provider Documentation](https://registry.terraform.io/providers/integrations/github/latest/docs)
- [Terraform Cloud Documentation](https://developer.hashicorp.com/terraform/cloud-docs)
- [GitHub API Documentation](https://docs.github.com/en/rest)

---

**Happy Infrastructure Coding!** 🚀
