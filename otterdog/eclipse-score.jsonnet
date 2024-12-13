local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local customRuleset(name) = 
  orgs.newRepoRuleset(name) {
    include_refs+: [
      std.format("refs/heads/%s", name),
    ],
    required_pull_request+: {
      required_approving_review_count: 1,
      dismisses_stale_reviews: true,
      requires_code_owner_review: true,
    },
  };

orgs.newOrg('eclipse-score') {
  settings+: {
    has_discussions: true,
    discussion_source_repository: "eclipse-score/score",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('eclipse-score.github.io') {
      description: "The landing page website for the Score project",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages: [
        "python",
      ],
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/",
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
      gh_pages_build_type: "workflow",
      has_discussions: false,
      topics+: [
        "landing-page",
        "score"
      ],
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('score') {
      description: "Score project main repository",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages: [
        "python",
      ],
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/score",
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
      gh_pages_build_type: "workflow",
      has_discussions: true,
      topics+: [
        "score"
      ],
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('bazel_registry') {
      description: "Score project bazel modules registry",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      topics+: [
        "score",
        "bazel",
        "registry"
      ],
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('process_description') {
      description: "Score project process description",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/process_description",
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
      gh_pages_build_type: "workflow",
      topics+: [
        "score",
        "process"
      ],
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('reference_integration') {
      description: "Score project integration repository",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      topics+: [
        "score",
        "integration"
      ],
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('inc_feo') {
      description: "Incubation repository for the fixed execution order framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/inc_feo",
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('inc_mw_com') {
      description: "Incubation repository for interprocess communication framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/inc_mw_com",
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('inc_mw_log') {
      description: "Incubation repository for logging framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/inc_mw_log",
      rulesets: [
        customRuleset("main")
      ],
    },
    orgs.newRepo('inc_mw_per') {
      description: "Incubation repository for persistency framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: true,
      homepage: "https://eclipse-score.github.io/inc_mw_per",
      rulesets: [
        customRuleset("main")
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}
