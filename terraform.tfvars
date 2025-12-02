github_owner = "zfael"

repositories = {
  "dota2-scripts" = {
    description = "Set of scripts for Dota 2 automation on top of Game State Integration Events"
    visibility  = "public"

    has_issues = true
    has_wiki   = false

    auto_init          = true
    gitignore_template = "Rust"
    license_template   = "mit"

    topics = ["rust", "dota2", "game-state-integration", "automation"]

    vulnerability_alerts = true

    branch_protection = {
      pattern                         = "main"
      require_conversation_resolution = true

      required_pull_request_reviews = {
        required_approving_review_count = 1
        dismiss_stale_reviews           = true
      }
    }
  }
}
