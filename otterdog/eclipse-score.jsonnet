# Overview, Defaults, Reference see https://otterdog.eclipse.org/projects/automotive.score

local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local default_review_rule = {
  # dismiss approved reviews automatically when a new commit is pushed
  dismisses_stale_reviews: true,

  # The number of approvals required before a pull request can be merged [0,10]
  required_approving_review_count: 1,

  # require an approved review in pull requests including files with a designated code owner
  requires_code_owner_review: true,

  # TODO: the most recent push must be approved by someone other than the person who pushed it
  # requires_last_push_approval: true,
};

local block_tagging(tags, bypass) =
 orgs.newRepoRuleset('tags-protection') {
  target: "tag",
  # bot has admin access anyway, but let's be explicit
  bypass_actors+: bypass, # + ["@eclipse-score-bot"] # Bypass_actors cannot be individuals, only role, team, or App: https://otterdog.readthedocs.io/en/latest/reference/organization/repository/bypass-actor/
  include_refs+: [std.format("refs/tags/%s", tag) for tag in tags],
  allows_creations: false,
  allows_deletions: false,
  allows_updates: false,

  # Those are not needed. Override in order to drop the defaults.
  required_pull_request: null,
  required_status_checks: null,
};

// Hint: Override all options as required when creating a new repository. See below for examples.
// Parameters:
//   name: The name of the repository.
//   pages: boolean, whether to create default documentation pages for the repository.
local newScoreRepo(name, pages = false) = orgs.newRepo(name) {
  // These are disabled by default
  dependabot_security_updates_enabled: true,

  // Default: Squash only.
  // More details: https://eclipse-score.github.io/score/main/contribute/general/git.html
  allow_rebase_merge: false,
  allow_merge_commit: false,
  allow_squash_merge: true,

  // Remove some features, to avoid having too many options where stuff is located
  has_discussions: false,
  has_projects: false,
  has_wiki: false,

  // Setup the default review rule for main branch.
  rulesets: [
    orgs.newRepoRuleset('main') {
      include_refs+: [
        "refs/heads/main"
      ],
      required_pull_request+: default_review_rule,
    },
  ],
} + if pages then {
  gh_pages_build_type: "workflow",
  homepage: "https://eclipse-score.github.io/" + name,
} else {};

local newModuleRepo(name) = newScoreRepo(name, true) {
  template_repository: "eclipse-score/module_template",
};

local newInfrastructureTeamRepo(name, pages = false) = newScoreRepo(name, pages) {
  // No special settings for infrastructure team repos at the moment
};

# Publication to pypi can only be triggered by infrastructure-maintainers and only from main branch or tag
local pypi_infra_env = orgs.newEnvironment('pypi') {
  // Note: we cannot use @eclipse-score/infrastructure-maintainers here,
  // because the team does not have write access, only the members.
  reviewers+: [
    "@AlexanderLanin",
    "@dcalavrezo-qorix",
    "@MaximilianSoerenPollak",
    "@nradakovic",
  ],
  deployment_branch_policy: "selected",
  branch_policies+: [
    "main",
    "tag:v*",
  ],
};

orgs.newOrg('automotive.score', 'eclipse-score') {
  settings+: {
    name: "Eclipse S-CORE",
    description: "",
    discussion_source_repository: "eclipse-score/score",
    has_discussions: true,
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
        "antonkri",
        "rmaddikery",
        "hoppe-and-dreams"
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
        "qor-lb",
        "pawelrutkaq",
        "vinodreddy-g"
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
        "qor-lb",
        "umaucher",
        "vinodreddy-g",
        "arkjedrz"
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
        "ramceb",
        "nradakovic",
        "4og",
      ],
    },
    orgs.newTeam('codeowner-baselibs_rust') {
      members+: [
      ],
    },
    orgs.newTeam('codeowner-nlohmann_json') {
      members+: [
        "4og",
      ],
    },
    orgs.newTeam('infrastructure-maintainers') {
      members+: [
        "AlexanderLanin",
        "dcalavrezo-qorix",
        "MaximilianSoerenPollak",
        "nradakovic",
      ],
    },
    orgs.newTeam('codeowner-kyron') {
      members+: [
        "pawelrutkaq",
        "vinodreddy-g",
        "qor-lb",
        "nicu1989",
      ],
    },
    orgs.newTeam('codeowner-config_management') {
      members+: [
        "antonkri",
        "4og",
        "michaelsaborov",
        "darkwisebear",
        "wei2374",
      ],
    },    
  ],
  variables+: [
    orgs.newOrgVariable("ECLIPSE_PROJECT") {
      value: "automotive.score",
      visibility: "public", # all repositories have access to this variable
    },
  ],
  secrets+: [
    orgs.newOrgSecret('DEVELOCITY_API_TOKEN') {
      value: "pass:bots/automotive.score/develocity.eclipse.org/api-token",
    },
    orgs.newOrgSecret('ECLIPSE_GITLAB_API_TOKEN') {
      value: "pass:bots/automotive.score/gitlab.eclipse.org/api-token",
    },
    orgs.newOrgSecret('SCORE_APPROVALS_PAT') {
      value: "pass:bots/automotive.score/github.com/approval-token",
    },
    orgs.newOrgSecret('SCORE_QNX_LICENSE') {
      selected_repositories+: [
        "toolchains_qnx",
        "persistency",
        "baselibs",
        "baselibs_rust",
        "communication",
        "logging",
        "reference_integration",
        "scrample",
        "bazel_cpp_toolchains",
        "kyron",
        "orchestrator",
        "ferrocene_toolchain_builder",
        "lifecycle",
        "rules_imagefs",
      ],
      value: "********",
      visibility: "selected",
    },
    orgs.newOrgSecret('SCORE_QNX_PASSWORD') {
      selected_repositories+: [
        "toolchains_qnx",
        "persistency",
        "baselibs",
        "baselibs_rust",
        "communication",
        "logging",
        "reference_integration",
        "scrample",
        "bazel_cpp_toolchains",
        "kyron",
        "orchestrator",
        "ferrocene_toolchain_builder",
        "lifecycle",
        "rules_imagefs",
      ],
      value: "********",
      visibility: "selected",
    },
    orgs.newOrgSecret('SCORE_QNX_USER') {
      selected_repositories+: [
        "toolchains_qnx",
        "persistency",
        "baselibs",
        "baselibs_rust",
        "communication",
        "logging",
        "reference_integration",
        "scrample",
        "bazel_cpp_toolchains",
        "kyron",
        "orchestrator",
        "ferrocene_toolchain_builder",
        "lifecycle",
        "rules_imagefs",
      ],
      value: "********",
      visibility: "selected",
    },
    orgs.newOrgSecret('RENOVATE_TOKEN') {
      value: "pass:bots/automotive.score/github.com/renovate-token",
    },
    orgs.newOrgSecret('GH_PUBLISH_TOKEN') {
      selected_repositories+: [
        "eclipse-score-website"
      ],
      value: "pass:bots/automotive.score/github.com/website-token",
      visibility: "selected"
    },
    orgs.newOrgSecret('SCORE_BOT_PAT') {
      value: "pass:bots/automotive.score/github.com/token-hd6226",
    },
    orgs.newOrgSecret('SCORE_BOT_CLASSIC_PAT') {
      value: "pass:bots/automotive.score/github.com/token-hd6722",
    },
  ],
  _repositories+:: [
    newInfrastructureTeamRepo('.github') {
      description: "Houses the organisation README",
      allow_rebase_merge: true,
      dependabot_security_updates_enabled: false,
      has_projects: true,
      has_wiki: true,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages+: [
        "actions",
      ],
      topics+: [
        "score"
      ],
    },

    newInfrastructureTeamRepo('bazel_registry') {
      description: "Score project bazel modules registry",
      topics+: [
        "bazel",
        "registry",
        "score"
      ],
      rulesets+: [
        block_tagging(
          [
            "*", # block all tag creations
            # alternatively, specify specific tags to block here, e.g. "v*"
          ],
          [
            "@eclipse-score/infrastructure-maintainers",
          ]
        ),
      ],
    },

    newScoreRepo('eclipse-score.github.io', pages = true) {
      description: "The landing page website for the Score project",
      homepage: "https://eclipse-score.github.io/",
      topics+: [
        "landing-page",
        "score"
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
    newScoreRepo('eclipse-score-website') {
      allow_rebase_merge: true,
      dependabot_security_updates_enabled: false,
      has_projects: true,
      has_wiki: true,
      rulesets: [], # reset rulesets
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      environments: [
        orgs.newEnvironment('pull-request-preview'),
      ],
    },
    newScoreRepo('eclipse-score-website-published') {
      allow_rebase_merge: true,
      dependabot_security_updates_enabled: false,
      has_projects: true,
      has_wiki: true,
      rulesets: [], # reset rulesets
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
    },
    newScoreRepo('eclipse-score-website-preview') {
      allow_rebase_merge: true,
      dependabot_security_updates_enabled: false,
      has_projects: true,
      has_wiki: true,
      rulesets: [], # reset rulesets
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages-preview",
      gh_pages_source_path: "/",
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('inc_feo') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages+: [
        "actions",
      ],
      description: "Incubation repository for the fixed execution order framework",
      homepage: "https://eclipse-score.github.io/inc_feo",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },
    orgs.newRepo('lifecycle') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages+: [
        "actions",
      ],
      description: "Repository for the lifecycle feature",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/lifecycle",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
      aliases: [
        "inc_lifecycle",
      ],
    },
    orgs.newRepo('score-crates') {
      allow_merge_commit: true,
      allow_update_branch: false,
      // TODO: re-enable after some code has been added to the repository
      // code_scanning_default_setup_enabled: true,
      // code_scanning_default_languages+: [
      //   "actions",
      // ],
      description: "Repository to provide a defined list of rust crates to be used as bzl_mods",
      homepage: "https://eclipse-score.github.io/score-crates",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
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
          required_pull_request+: default_review_rule,
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
          required_pull_request+: default_review_rule,
        },
      ],
    },
    newScoreRepo('persistency', true) {
      aliases: [
        "inc_mw_per",
      ],
      allow_merge_commit: true,
      allow_update_branch: false,
      description: "Repository for persistency framework",
      environments: [
        orgs.newEnvironment('workflow-approval') {
          deployment_branch_policy: "all",
          reviewers+: [
            "@eclipse-score/automotive-score-committers",
          ],
          wait_timer: 1,
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
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('itf') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages: [
        "actions",
      ],
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
          required_pull_request+: default_review_rule,
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
    orgs.newRepo('bazel_platforms') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Bazel platform definitions used by S-CORE modules",
      homepage: "https://eclipse-score.github.io/bazel_platforms",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },
    newScoreRepo('process_description', pages = true) {
      has_projects: true,

      // Custom merge settings.
      allow_merge_commit: true,
      allow_rebase_merge: true,
      allow_update_branch: false,
      description: "Score project process description",
      topics+: [
        "process",
        "score"
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
    newInfrastructureTeamRepo('reference_integration', true) {
      description: "Score project integration repository",
      topics+: [
        "integration",
      ],
    },

    newScoreRepo('os_images', false) {
      description: "OS Images for testing and deliveries",
    },

    orgs.newRepo('score') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "actions",
      ],
      code_scanning_default_setup_enabled: true,
      description: "Score project main repository",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_discussions: true,
      has_wiki: true,
      homepage: "https://eclipse-score.github.io/score",
      topics+: [
        "score"
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },

    newInfrastructureTeamRepo('tooling') {
      description: "Tooling for Eclipse S-CORE",
      environments+: [
        orgs.newEnvironment('copilot'),
      ],
    },
    newInfrastructureTeamRepo('tools') {
      description: "Home of score-tools, the new pypi based tools approach",
      environments+: [
        orgs.newEnvironment('copilot'),
        pypi_infra_env,
      ],
    },

    orgs.newRepo('baselibs') {
      allow_merge_commit: false,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: false,
      description: "base libraries including common functionality",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/baselibs",
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
          required_pull_request+: default_review_rule,
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
      allow_update_branch: true,
      code_scanning_default_languages+: [
        "actions",
        "c-cpp",
        "python",
        # "rust", # not yet supported by GH API: https://docs.github.com/en/rest/code-scanning/code-scanning?apiVersion=2022-11-28#update-a-code-scanning-default-setup-configuration
      ],
      code_scanning_default_setup_enabled: true,
      has_discussions: true,
      has_wiki: false,
      description: "Repository for the communication module LoLa",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
          bypass_actors+: [
            "@eclipse-score/codeowner-lola",
          ],
          allows_force_pushes: false,
          requires_linear_history: true,
        },
        orgs.newRepoRuleset('linear_history') {
          include_refs+: [
            "~ALL"
          ],
          bypass_actors+: [
            "@eclipse-score/codeowner-lola",
          ],
          requires_linear_history: true,
        },
        orgs.newRepoRuleset('release_creation_by_codeowners_only') {
          name: "Restrict Release Creation to Code Owners",
          target: "tag",
          enforcement: "active",
          bypass_actors+: [
            "@eclipse-score/codeowner-lola",
          ],
          include_refs+: [
            "refs/tags/*",
          ],
          allows_creations: false,
          allows_deletions: false,
          allows_updates: false,
        },
      ],
      environments: [
        orgs.newEnvironment('workflow-approval') {
          deployment_branch_policy: "all",
          reviewers+: [
            "@eclipse-score/automotive-score-committers",
          ],
          wait_timer: 1,
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
          required_pull_request+: default_review_rule,
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
          required_pull_request+: default_review_rule,
        },
      ],
    },
    newScoreRepo('rules_imagefs', false) {
      description: "Repository for Image FileSystem Bazel rules and toolchains definitions",
    },
    newScoreRepo('bazel_cpp_toolchains', false) {
      description: "Bazel C/C++ toolchain configuration repository",
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
          required_pull_request+: default_review_rule,
        },
      ],
    },
    orgs.newRepo('toolchains_gcc_packages') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Bazel toolchains for GNU GCC",
      homepage: "https://eclipse-score.github.io/toolchains_gcc_packages",
      code_scanning_default_languages+: [
        "actions",
      ],
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },
    orgs.newRepo('toolchains_qnx') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "actions",
        "python",
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
          required_pull_request+: default_review_rule,
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
          required_pull_request+: default_review_rule,
        },
      ],
    },

    newInfrastructureTeamRepo('ferrocene_toolchain_builder') {
      description: "Builder for Ferrocene artifacts",
    },

    newInfrastructureTeamRepo('module_template', pages = true) {
      description: "C++ & Rust Bazel Template Repository",
      is_template: true,
    },

    newInfrastructureTeamRepo('cicd-workflows') {
      description: "Reusable GitHub Actions workflows for CI/CD automation",
    },

    newInfrastructureTeamRepo('docs-as-code', pages = true) {
      description: "Docs-as-code tooling for Eclipse S-CORE",

      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/docs-as-code",
      environments+: [
        orgs.newEnvironment('copilot'),
      ],
    },

    orgs.newRepo('orchestrator') {
      aliases: [
        "inc_orchestrator",
      ],
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages+: [
        "actions",
        "python",
      ],
      description: "Orchestration framework & Safe async runtime for Rust",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/orchestrator",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },

    orgs.newRepo('inc_score_codegen') {
      allow_merge_commit: true,
      allow_update_branch: false,
      // code must be present to enable code scanning
      // code_scanning_default_languages+: [
      //   "python"
      // ],
      code_scanning_default_setup_enabled: true,
      description: "Incubation repository for DSL/code-gen specific to score project",
      homepage: "https://eclipse-score.github.io/inc_score_codegen",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },

    newScoreRepo("nlohmann_json", true) {
        aliases: [
          "inc_nlohmann_json",
        ],
        description: "Nlohmann JSON Library",
        forked_repository: "nlohmann/json",
        default_branch: "main",
        allow_rebase_merge: true,
        allow_merge_commit: true,
        has_discussions: true,
        has_wiki: true,
        dependabot_alerts_enabled: true,
        dependabot_security_updates_enabled: false,
        rulesets: [
          orgs.newRepoRuleset('main') {
            include_refs+: [
              "refs/heads/main"
            ],
            required_pull_request+: default_review_rule,
            allows_force_pushes: false,
            requires_linear_history: true,
          },
        ],
    },

    newScoreRepo('baselibs_rust', true) {
      allow_merge_commit: true,
      allow_update_branch: false,
      description: "Repository for the Rust baselibs",
      environments: [
        orgs.newEnvironment('workflow-approval') {
          deployment_branch_policy: "all",
          reviewers+: [
            "@eclipse-score/automotive-score-committers",
          ],
          wait_timer: 1,
        },
      ],
      // Override the rulesets
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          bypass_actors+: [
            "@eclipse-score/codeowner-baselibs_rust",
          ],
          required_pull_request+: default_review_rule,
        },
      ],
      template_repository: "eclipse-score/module_template",
    },

    newInfrastructureTeamRepo('score_rust_policies') {
      description: "Centralized Rust linting and formatting policies for S-CORE, including safety-critical guidelines.",
      gh_pages_build_type: "workflow",
      homepage: "https://eclipse-score.github.io/score_rust_policies",
      topics+: [
        "rust",
        "linting",
        "formatting",
        "score",
        "policy",
      ],
    },

    newInfrastructureTeamRepo('bazel_registry_ui') {
      description: "House the ui for bazel_registry in Score",
      rulesets: [], # reset rulesets
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      homepage: "https://eclipse-score.github.io/bazel_registry_ui",
      forked_repository:"bazel-contrib/bcr-ui",
    },

    newInfrastructureTeamRepo("rules_rust") {
      description: "S-CORE fork of bazelbuild/rules_rust",
      forked_repository: "bazelbuild/rules_rust",
      default_branch: "score_main",
      rulesets+: [
        orgs.newRepoRuleset('score_main') {
          include_refs+: [
            "refs/heads/score_main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },

    newInfrastructureTeamRepo('more-disk-space') {
      description: "GitHub Action to make more disk space available in Ubuntu based GitHub Actions runners",
    },

    newInfrastructureTeamRepo('apt-install') {
      description: "GitHub Action to execute apt-install in a clever way",
    },

    newInfrastructureTeamRepo('devcontainer') {
      description: "Common Devcontainer for Eclipse S-CORE",
    },

    newInfrastructureTeamRepo('dash-license-scan') {
      description: "pipx/uvx wrapper for the dash-licenses tool",
      environments+: [
        pypi_infra_env,
      ],
    },
    
    newInfrastructureTeamRepo('test_integration') {
      description: "Tests for the integration infrastructure",
    },
    
    newInfrastructureTeamRepo('test_module_a') {
      description: "Dummy module for testing the integration infrastructure",
      template_repository: "eclipse-score/module_template",
    },
    
    newInfrastructureTeamRepo('test_module_b') {
      description: "Dummy module for testing the integration infrastructure",
      template_repository: "eclipse-score/module_template",
    },

    newInfrastructureTeamRepo('infrastructure', true) {
      description: "All general information related to the development and integration infrastructure",
    },

    orgs.newRepo('testing_tools') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: true,
      description: "Repository for testing utilities",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
        },
      ],
    },

    newModuleRepo('inc_json') {
      description: "Incubation repository for JSON module",
    },
    newModuleRepo('feo') {
      description: "Repository for the Fixed Order Execution (FEO) framework",
    },
    newModuleRepo('inc_daal') {
      description: "Incubation repository for DAAL module",
    },
    newModuleRepo('inc_os_autosd') {
      description: "Incubation repository for AutoSD Development Platform",
    },
    newModuleRepo('bazel-tools-python') {
      description: "Repository for python static code checker",
    },
    newModuleRepo('inc_config_management') {
      description: "Incubation repository for config management",
    },
    newModuleRepo('bazel-tools-cc') {
      description: "Repository for clang-tidy based static code checker",
    },
    newModuleRepo('logging') {
      allow_rebase_merge: true,
      description: "Repository for logging daemon",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
          bypass_actors+: [
            "@eclipse-score/cft-logging",
          ],
          allows_force_pushes: false,
          requires_linear_history: true,
        },
      ],
    },
    newModuleRepo('scrample') {
      description: "Repository for example component",
      environments: [
        orgs.newEnvironment('workflow-approval') {
          deployment_branch_policy: "all",
          reviewers+: [
            "@eclipse-score/automotive-score-committers",
          ],
          wait_timer: 1,
        },
      ],
    },
    newModuleRepo('inc_abi_compatible_datatypes') {
      description: "Incubation repository for ABI compatible data types feature",
    },
    newModuleRepo('inc_someip_gateway') {
      description: "Incubation repository for SOME/IP gateway feature",
    },
    newModuleRepo('inc_time') {
      description: "Incubation repository for time feature",
    },
    newModuleRepo('inc_diagnostics') {
      description: "Incubation repository for diagnostics feature",
    },
    newModuleRepo('inc_ai_platform') {
      description: "Incubation repository for AI platform feature",
    },
    newModuleRepo('inc_gen_ai') {
      description: "Incubation repository for Generative AI feature",
    },
    newModuleRepo('inc_security_crypto') {
      description: "Incubation repository for Security & Cryptography feature",
    },
    newModuleRepo('kyron') {
      allow_merge_commit: true,
      description: "Safe async runtime for Rust",
    },
    newModuleRepo('inc_time') {
      allow_merge_commit: true,
      description: "incubation repo for time sync module",
    },
    orgs.newRepo('config_management') {
      allow_merge_commit: false,
      allow_update_branch: false,
      code_scanning_default_setup_enabled: false,
      gh_pages_build_type: "workflow",
      template_repository: "eclipse-score/module_template",
      has_discussions: true,
      has_wiki: false,
      description: "Repository for config management",
      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main"
          ],
          required_pull_request+: default_review_rule,
          bypass_actors+: [
            "@eclipse-score/codeowner-config_management",
          ],
          allows_force_pushes: false,
          requires_linear_history: true,
        },
      ],
    }
  ],
}
