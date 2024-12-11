local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

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
      delete_branch_on_merge: false,
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
      web_commit_signoff_required: false,
    },
    orgs.newRepo('score') {
      description: "Score project main repository",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages: [
        "python",
      ],
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
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
      web_commit_signoff_required: false,
    },

    orgs.newRepo('inc_feo') {
      description: "Incubation repository for the fixed execution order framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      homepage: "https://eclipse-score.github.io/inc_feo",
    },
    orgs.newRepo('inc_mw_com') {
      description: "Incubation repository for interprocess communication framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      homepage: "https://eclipse-score.github.io/inc_mw_com",
    },
    orgs.newRepo('inc_mw_log') {
      description: "Incubation repository for logging framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      homepage: "https://eclipse-score.github.io/inc_mw_log",
    },
    orgs.newRepo('inc_mw_per') {
      description: "Incubation repository for persistency framework",
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      homepage: "https://eclipse-score.github.io/inc_mw_per",
    },

  ],
}
