fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios run_all_tests

```sh
[bundle exec] fastlane ios run_all_tests
```

Run tests

### ios prepare_dev

```sh
[bundle exec] fastlane ios prepare_dev
```

Release preparation on dev branch
  Params: 
  1. bump_type - The type of this version bump. Available: patch, minor, major (ex. bump_type:patch) (optional)
  2. version - Specific app version (ex. version:1.0.3) (optional)

### ios prepare_main

```sh
[bundle exec] fastlane ios prepare_main
```

Release actions on main branch

### ios submit_prod_build

```sh
[bundle exec] fastlane ios submit_prod_build
```

Submit a new App Store Build to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
