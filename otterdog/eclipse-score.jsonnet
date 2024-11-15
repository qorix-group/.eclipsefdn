local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-score') {
  settings+: {
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('eclipse-score.github.io') {
      description: "The landing page website for the Score project",
      allow_merge_commit: true,
      allow_update_branch: false,
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
    }
  ],
}
