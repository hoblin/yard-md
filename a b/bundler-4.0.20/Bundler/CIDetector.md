# module Bundler::CIDetector
Defined in: `lib/bundler/ci_detector.rb`

## Constants

### ENV_DESCRIPTORS

```ruby
ENV_DESCRIPTORS = {
  "TRAVIS" => "travis",
  "CIRCLECI" => "circle",
  "CIRRUS_CI" => "cirrus",
  "DSARI" => "dsari",
  "SEMAPHORE" => "semaphore",
  "JENKINS_URL" => "jenkins",
  "BUILDKITE" => "buildkite",
  "GO_SERVER_URL" => "go",
  "GITLAB_CI" => "gitlab",
  "GITHUB_ACTIONS" => "github",
  "TASKCLUSTER_ROOT_URL" => "taskcluster",
  "CI" => "ci",
}.freeze
```

For each CI, this env suffices to indicate that we're on *that* CI's
containers. (A few of them only supply a CI_NAME variable, which is also
nice). And if they set "CI" but we can't tell which one they are, we also
want to know that - a bare "ci" without another token tells us as much.

### ENV_INDICATORS

```ruby
ENV_INDICATORS = [
  "CI",
  "CI_NAME",
  "CONTINUOUS_INTEGRATION",
  "BUILD_NUMBER",
  "CI_APP_ID",
  "CI_BUILD_ID",
  "CI_BUILD_NUMBER",
  "RUN_ID",
  "TASKCLUSTER_ROOT_URL",
].freeze
```

Any of these being set is a reasonably reliable indicator that we are
executing in a CI environment.

## Class methods

### .ci?

Returns: `Boolean`

### .ci_strings
