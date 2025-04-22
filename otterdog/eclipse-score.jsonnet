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
        "arsibo",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-feo') {
      members+: [
        "AlexanderLanin",
        "FScholPer",
        "MathiasDanzeisen",
        "antonkri",
        "arsibo",
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
        "arsibo",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "pahmann",
        "qor-lb"
      ],
    },
    orgs.newTeam('cft-orchestration') {
      members+: [
        "AlexanderLanin",
        "FScholPer",
        "MathiasDanzeisen",
        "antonkri",
        "arsibo",
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
        "arsibo",
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
        "arsibo",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "qor-lb"
      ],
    },
    orgs.newTeam('community-operational') {
      members+: [
        "AlexanderLanin",
        "FScholPer",
        "PhilipPartsch",
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
        "PandaeDo",
        "PhilipPartsch",
        "antonkri",
        "aschemmel-tech",
        "johannes-esr",
        "ltekieli",
        "markert-r",
        "masc2023",
        "pahmann",
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
        "pahmann",
        "qor-lb"
      ],
    },
    orgs.newTeam('codeowner-lola') {
      members+: [
        "castler",
        "hoe-jo",
        "LittleHuba"
      ],
    },
    orgs.newTeam('codeowner-baselibs') {
      members+: [
        "castler",
        "hoe-jo",
        "LittleHuba",
        "ramceb"
      ],
    },
  ],
  secrets+: [
    orgs.newOrgSecret('DEVELOCITY_API_TOKEN') {
      value: "pass:bots/automotive.score/develocity.eclipse.org/api-token",
    },
    orgs.newOrgSecret('ECLIPSE_GITLAB_API_TOKEN') {
      value: "pass:bots/automotive.score/gitlab.eclipse.org/api-token",
    },
    orgs.newOrgSecret('SCORE_QNX_LICENSE') {
      selected_repositories+: [
        "toolchains_qnx"
      ],
      value: "********",
      visibility: "selected",
    },
    orgs.newOrgSecret('SCORE_QNX_PASSWORD') {
      selected_repositories+: [
        "toolchains_qnx"
      ],
      value: "********",
      visibility: "selected",
    },
    orgs.newOrgSecret('SCORE_QNX_USER') {
      selected_repositories+: [
        "toolchains_qnx"
      ],
      value: "********",
      visibility: "selected",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
    },
    orgs.newRepo('bazel_registry') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages+: [
        "python"
      ],
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
      code_scanning_default_languages+: [
        "python"
      ],
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
    orgs.newRepo('inc_process_test_management') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for Process - Sphinx-Test management",
      homepage: "https://eclipse-score.github.io/inc_process_test_management",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: false,
          },
        },
      ],
    },
    orgs.newRepo('inc_process_variant_management') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for Process - Sphinx-Variant management",
      homepage: "https://eclipse-score.github.io/inc_process_variant_management",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: {
            dismisses_stale_reviews: true,
            required_approving_review_count: 1,
            requires_code_owner_review: false,
          },
        },
      ],
    },
    orgs.newRepo('itf') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Integration Testing Framework repository",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_discussions: true,
      homepage: "https://eclipse-score.github.io/itf",
      topics+: [
        "itf",
        "score",
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
          required_status_checks+: {
            status_checks+: [
              "itf-build-all",
              "itf-examples-build-all",
            ],
          },
          required_merge_queue: orgs.newMergeQueue() {
            merge_method: "MERGE",
          },
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
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
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('tooling') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      description: "Repository for hosting score host tools",
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
    orgs.newRepo('baselibs') {
      allow_merge_commit: false,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: false,
      description: "base libraries including common functionality",
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
          bypass_actors+: [
            "@eclipse-score/codeowner-baselibs",
          ],
          allows_force_pushes: false,
          requires_linear_history: true,
        },
      ],
    },
    orgs.newRepo('communication') {
      allow_merge_commit: false,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: false,
      description: "Repository for the communication module LoLa",
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
          bypass_actors+: [
            "@eclipse-score/codeowner-lola",
          ],
          allows_force_pushes: false,
          requires_linear_history: true,
        },
      ],
    },
    orgs.newRepo('operating_system') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Repository for the module operating system",
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
    orgs.newRepo('examples') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Hosts templates and examples for score tools and workflows",
      homepage: "https://eclipse-score.github.io/examples",
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
    orgs.newRepo('toolchains_gcc') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Bazel toolchains for GNU GCC",
      homepage: "https://eclipse-score.github.io/toolchains_gcc",
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
    orgs.newRepo('toolchains_gcc_packages') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Bazel toolchains for GNU GCC",
      homepage: "https://eclipse-score.github.io/toolchains_gcc_packages",
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
    orgs.newRepo('toolchains_qnx') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      description: "Bazel toolchains for QNX",
      homepage: "https://eclipse-score.github.io/toolchains_qnx",
      environments: [
        orgs.newEnvironment('workflow-approval') {
          deployment_branch_policy: "all",
          reviewers+: [
            "@eclipse-score/automotive-score-committers",
          ],
          wait_timer: 1,
        },
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
          required_status_checks+: {
            status_checks+: [
              "toolchains-qnx-build-all",
            ],
          },
          required_merge_queue: orgs.newMergeQueue() {
            merge_method: "MERGE",
          },
        },
      ],
    },
    orgs.newRepo('toolchains_rust') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Rust toolchains",
      homepage: "https://eclipse-score.github.io/toolchains_rust",
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
    orgs.newRepo('module_template') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "C++ & Rust Bazel Template Repository",
      is_template: true,  // Enable template repository functionality
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
    orgs.newRepo('cicd-workflows') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Reusable GitHub Actions workflows for CI/CD automation",
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
    orgs.newRepo('process') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Score process and docs-as-code repository",
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
  ],
}
