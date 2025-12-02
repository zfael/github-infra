terraform {
  required_version = ">= 1.6.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  # Terraform Cloud backend configuration
  # Update these values for your Terraform Cloud organization and workspace
  cloud {
    organization = "bertelli"

    workspaces {
      name = "github-infra"
    }
  }
}
