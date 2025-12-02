# Importing Existing Repositories

This guide explains how to import existing GitHub repositories into Terraform management.

## Manual Import Process

### Step 1: Add Repository Configuration

Add the repository to `terraform.tfvars`. Match the current settings as closely as possible:

```hcl
repositories = {
  "existing-repo" = {
    description = "My existing repository"
    visibility  = "private"  # or "public"
    
    has_issues = true
    has_wiki   = false
    
    topics = ["existing", "imported"]
    
    # Add branch_protection block if the repo has protection
    branch_protection = {
      pattern = "main"
      
      required_pull_request_reviews = {
        required_approving_review_count = 1
        dismiss_stale_reviews           = true
      }
    }
  }
}
```

### Step 2: Import Repository Resource

```bash
terraform import 'module.repositories["existing-repo"].github_repository.this' zfael/existing-repo
```

### Step 3: Import Branch Protection (if exists)

Check if your repo has branch protection:
- Go to: https://github.com/zfael/existing-repo/settings/branches

If it has protection on `main`:

```bash
terraform import 'module.branch_protection["existing-repo"].github_branch_protection.this' zfael/existing-repo:main
```

For other branches, replace `main` with the branch pattern.

### Step 4: Verify Import

```bash
terraform plan
```

This will show any differences between your configuration and the actual repository state.

### Step 5: Adjust Configuration

If `terraform plan` shows changes you don't want:
1. Update `terraform.tfvars` to match the current state
2. Run `terraform plan` again
3. Repeat until plan shows no changes (or only desired changes)

### Step 6: Apply if Needed

If you want to apply any differences:

```bash
terraform apply
```