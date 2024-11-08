local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-score') {
  settings+: {
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "read",
    },
  },
}
