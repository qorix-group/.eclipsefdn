local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('automotive.score', 'eclipse-score') {
  settings+: {
    discussion_source_repository: "eclipse-score/score",
    has_discussions: true,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  teams+: [
    orgs.newTeam('automotive-score-technical-leads') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-communication') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-feo') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-logging') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-orchestration') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-persistency') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('community-architecture') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('community-operational') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('community-process') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('community-testing') {
      members+: [
        "FScholPer",
        "antonkri",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
    },
    orgs.newRepo('bazel_registry') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Score project bazel modules registry",
      topics+: [
        "bazel",
        "registry",
        "score"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
    },
    orgs.newRepo('eclipse-score.github.io') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      description: "The landing page website for the Score project",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/",
      topics+: [
        "landing-page",
        "score"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('inc_feo') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for the fixed execution order framework",
      homepage: "https://eclipse-score.github.io/inc_feo",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
    },
    orgs.newRepo('inc_mw_com') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for interprocess communication framework",
      homepage: "https://eclipse-score.github.io/inc_mw_com",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
    },
    orgs.newRepo('inc_mw_log') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for logging framework",
      homepage: "https://eclipse-score.github.io/inc_mw_log",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
    },
    orgs.newRepo('inc_mw_per') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for persistency framework",
      homepage: "https://eclipse-score.github.io/inc_mw_per",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
    },
    orgs.newRepo('process_description') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Score project process description",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/process_description",
      topics+: [
        "process",
        "score"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('reference_integration') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Score project integration repository",
      topics+: [
        "integration",
        "score"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
    },
    orgs.newRepo('score') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      description: "Score project main repository",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_discussions: true,
      homepage: "https://eclipse-score.github.io/score",
      topics+: [
        "score"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          deployment_branch_policy: "all"
        },
      ],
    },
    orgs.newRepo('itf') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      description: "Integration Testing Framework repository",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_discussions: true,
      homepage: "https://eclipse-score.github.io/itf",
      topics+: [
        "score",
        "itf",
        "testing"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: true,
          },
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages') {
          deployment_branch_policy: "all"
        },
      ],
    },
  ],
}
